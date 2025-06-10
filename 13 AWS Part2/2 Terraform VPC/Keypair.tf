resource "aws_key_pair" "dove-key" {
  key_name   = "dove-key"
  public_key = ""
}

resource "aws_key_pair" "test-key" {
  key_name   = "test-key"
  public_key = ""
}