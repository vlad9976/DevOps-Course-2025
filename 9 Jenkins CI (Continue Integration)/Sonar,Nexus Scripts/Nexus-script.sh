#!/bin/bash

# Install Java 17 (Amazon Corretto)
rpm --import https://yum.corretto.aws/corretto.key
curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
yum install -y java-17-amazon-corretto-devel wget

# Download and install Nexus
mkdir -p /opt/nexus /tmp/nexus
cd /tmp/nexus

NEXUSURL="https://download.sonatype.com/nexus/3/nexus-unix-x86-64-3.78.0-14.tar.gz"
wget $NEXUSURL -O nexus.tar.gz
tar xzvf nexus.tar.gz

NEXUSDIR=$(tar -tf nexus.tar.gz | head -1 | cut -d '/' -f1)
rm -f nexus.tar.gz

cp -r /tmp/nexus/* /opt/nexus/
useradd -r -s /sbin/nologin nexus
chown -R nexus:nexus /opt/nexus

# Configure Nexus systemd service
cat <<EOT > /etc/systemd/system/nexus.service
[Unit]
Description=nexus service
After=network.target

[Service]
Type=forking
LimitNOFILE=65536
ExecStart=/opt/nexus/$NEXUSDIR/bin/nexus start
ExecStop=/opt/nexus/$NEXUSDIR/bin/nexus stop
User=nexus
Restart=on-abort

[Install]
WantedBy=multi-user.target
EOT

echo 'run_as_user="nexus"' > /opt/nexus/$NEXUSDIR/bin/nexus.rc

# Start and enable service
systemctl daemon-reload
systemctl start nexus
systemctl enable nexus
