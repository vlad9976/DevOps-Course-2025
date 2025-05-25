# Find the latest Ubuntu 22.04 AMI from Canonical
data "aws_ami" "amiID" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical's AWS account ID
}

# Output the AMI ID
output "ami_id" {
  description = "AMI ID of the latest Ubuntu 22.04 image"
  value       = data.aws_ami.amiID.id
}
