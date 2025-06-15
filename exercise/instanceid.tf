data "aws_ami" "ami_id" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical

}

data "aws_region" "current" {}

output "instance_id" {
  description = "value of the instance id"
  value       = data.aws_ami.ami_id.id
}

output "region" {
  description = "value of the region"
  value       = data.aws_region.current.name

}
