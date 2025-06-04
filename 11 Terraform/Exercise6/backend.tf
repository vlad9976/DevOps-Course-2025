terraform {
  backend "s3" {
    bucket = "terraform-master15878"
    key    = "terraform/backend"
    region = "us-east-1"
  }
}