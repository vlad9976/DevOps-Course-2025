#!/bin/bash

# Kernel limits
cp /etc/sysctl.conf /root/sysctl.conf_backup
cat <<EOT > /etc/sysctl.conf
vm.max_map_count=262144
fs.file-max=65536
EOT
sysctl -p

cp /etc/security/limits.conf /root/sec_limit.conf_backup
cat <<EOT > /etc/security/limits.conf
sonarqube   -   nofile   65536
sonarqube   -   nproc    4096
EOT

# Java
apt update -y
apt install openjdk-17-jdk -y

# PostgreSQL setup
wget -q https://www.postgresql.org/media/keys/ACCC4CF8.asc -O - | apt-key add -
sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" >> /etc/apt/sources.list.d/pgdg.list'
apt update && apt install postgresql postgresql-contrib -y
systemctl enable --now postgresql

# PostgreSQL user and DB
echo "postgres:admin123" | chpasswd
runuser -l postgres -c "createuser sonar"
sudo -i -u postgres psql <<EOF
ALTER USER sonar WITH ENCRYPTED PASSWORD 'admin123';
CREATE DATABASE sonarqube OWNER sonar;
GRANT ALL PRIVILEGES ON DATABASE sonarqube TO sonar;
EOF

# SonarQube setup
mkdir -p /sonarqube && cd /sonarqube
curl -O https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-9.9.8.100196.zip
apt install unzip -y
unzip sonarqube-9.9.8.100196.zip -d /opt/
mv /opt/sonarqube-9.9.8.100196 /opt/sonarqube

groupadd sonar
useradd -c "SonarQube - User" -d /opt/sonarqube/ -g sonar sonar
chown -R sonar:sonar /opt/sonarqube/

cat <<EOT > /opt/sonarqube/conf/sonar.properties
sonar.jdbc.username=sonar
sonar.jdbc.password=admin123
sonar.jdbc.url=jdbc:postgresql://localhost/sonarqube
sonar.web.host=0.0.0.0
sonar.web.port=9000
sonar.web.javaAdditionalOpts=-server
sonar.search.javaOpts=-Xmx512m -Xms512m -XX:+HeapDumpOnOutOfMemoryError
sonar.log.level=INFO
sonar.path.logs=logs
EOT

cat <<EOT > /etc/systemd/system/sonarqube.service
[Unit]
Description=SonarQube service
After=syslog.target network.target

[Service]
Type=forking
ExecStart=/opt/sonarqube/bin/linux-x86-64/sonar.sh start
ExecStop=/opt/sonarqube/bin/linux-x86-64/sonar.sh stop
User=sonar
Group=sonar
Restart=always
LimitNOFILE=65536
LimitNPROC=4096

[Install]
WantedBy=multi-user.target
EOT

systemctl daemon-reload
systemctl enable sonarqube

# Reverse proxy via Nginx
apt install nginx -y
rm -f /etc/nginx/sites-{available,enabled}/default

cat <<EOT > /etc/nginx/sites-available/sonarqube
server {
    listen 80;
    server_name sonarqube.groophy.in;

    access_log /var/log/nginx/sonar.access.log;
    error_log  /var/log/nginx/sonar.error.log;

    location / {
        proxy_pass http://127.0.0.1:9000;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto http;
    }
}
EOT

ln -s /etc/nginx/sites-available/sonarqube /etc/nginx/sites-enabled/sonarqube
systemctl enable nginx

ufw allow 80,9000,9001/tcp

echo "System reboot in 30 seconds..."
sleep 30
reboot
