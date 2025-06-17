resource "aws_key_pair" "aws-key-terraform" {
  key_name   = "aws-key-terraform"
  public_key = file("aws-key-terraform.pub") # Ensure you have a public key at this path

}
