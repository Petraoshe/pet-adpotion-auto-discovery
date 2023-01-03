resource "aws_instance" "Bastion_Host" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.key_name
  vpc_security_group_ids      = [var.vpc_security_group_ids]
  associate_public_ip_address = var.associate_public_ip_address
  provisioner "file" {
    source      = "~/Keypairs/PACAAD1"
    destination = "/home/ec2-user/PACAAD1"
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("~/Keypairs/PACAAD1")
    host        = self.public_ip
  }
  user_data = <<-EOF
#!/bin/bash
sudo hostnamectl set-hostname Bastion
EOF
  tags = {
    Name = var.Bastion_Host_Name
  }
}
