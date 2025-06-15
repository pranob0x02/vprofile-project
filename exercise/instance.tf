data "aws_ami" "ubuntu_ami" {
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

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu_ami.id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.aws-key-terraform.key_name

  vpc_security_group_ids = [
    aws_security_group.aws-sg.id
  ]
  availability_zone = "us-east-1a"
  tags = {
    Name = "web-instance"
  }
}

output "web_instance_ip" {
  description = "The IP of the web instance"
  value       = aws_instance.web.public_ip
}
