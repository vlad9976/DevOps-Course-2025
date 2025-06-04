# Doc
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair
resource "aws_key_pair" "deployer" {
  key_name   = "terra-key"
  public_key = file("terra-key.pub")
}