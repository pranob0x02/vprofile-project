# data "aws_ami" "ubuntu_ami" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
#   }
#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }
#   owners = ["099720109477"] # Canonical
# }

resource "aws_instance" "web" {
  ami           = var.ami_id[var.region]
  instance_type = var.instance_type
  key_name      = aws_key_pair.aws-key-terraform.key_name

  vpc_security_group_ids = [
    aws_security_group.aws-sg.id
  ]
  availability_zone = var.availability_zone
  tags = {
    Name = "ubuntu-instance"
  }

  connection {
    type        = "ssh"
    user        = var.user
    private_key = file("aws-key-terraform") # Ensure you have the private key at this path
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "web.sh"
    destination = "/tmp/web.sh"
  }

  provisioner "remote-exec" {

    inline = [
      "chmod +x /tmp/web.sh",
      "sudo /tmp/web.sh"
    ]
  }

}

output "web_instance_ip" {
  description = "The IP of the web instance"
  value       = aws_instance.web.public_ip
}
