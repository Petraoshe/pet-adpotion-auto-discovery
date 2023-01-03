# Provision Jenkins and Docker_host SecurityGroup
resource "aws_security_group" "JD_SG" {
  name        = var.JD_SG_name
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from PACAAD1_VPC"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  ingress {
    description = "Allow custom_http from PACAAD1_VPC"
    from_port   = var.Custom_http
    to_port     = var.Custom_http
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr]
  }

  ingress {
    description = "Allow http from PACAAD1_VPC"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_cidr]
  }
  tags = {
    Name = var.JD_SG_name
  }
}

# Provision Bastion_host and Ansible_node Security_Group
resource "aws_security_group" "BA_SG" {
  name        = var.BA_SG_name
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from PACAAD1_VPC"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = [var.all_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_cidr]
  }
  tags = {
    Name = var.BA_SG_name
  }
}

# Create  Security Group Database
resource "aws_security_group" "DB_SG" {
  name        = var.DB_SG_name
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from PACAAD1_VPC"
    from_port   = var.mysql
    to_port     = var.mysql
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_cidr]
  }
  tags = {
    Name = var.DB_SG_name
  }
}
