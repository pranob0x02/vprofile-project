data "aws_ami" "ubuntuamiID" {
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

resource "aws_instance" "bastion_host" {
  ami           = data.aws_ami.ubuntuamiID.id
  instance_type = "t3.micro"
  key_name      = aws_key_pair.aws-key-terraform.key_name
  subnet_id     = module.vpc.public_subnets[0]

  vpc_security_group_ids = [aws_security_group.vprofile-bastion-sg.id]

  tags = {
    Name    = "BastionHost"
    Project = var.PROJECT_NAME
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("aws-key-terraform") # Ensure you have the private key at this path
    host        = self.public_ip
  }

  provisioner "file" {
    content = templatefile("templates/db-deploy.tmpl", {
      rds-endpoint = aws_db_instance.vprofile-rds-instance.address
      db_name      = var.db_name
      username     = var.username
      password     = var.password
    })
    destination = "/tmp/vprofile-db-deploy.sh"
  }

  provisioner "remote-exec" {

    inline = [
      "chmod +x /tmp/vprofile-db-deploy.sh",
      "sudo /tmp/vprofile-db-deploy.sh"
    ]
  }

}
