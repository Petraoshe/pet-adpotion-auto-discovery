# Create Docker host Server
resource "aws_instance" "PACAAD1-Docker-Host" {
  ami                         = var.ami
  instance_type               = var.instance_type
  vpc_security_group_ids      = [var.vpc_security_group_ids]
  subnet_id                   = var.Subnet_id
  key_name                    = var.key_name
  associate_public_ip_address = false

  user_data              = <<-EOF
#!/bin/bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum update -y
sudo yum install docker-ce docker-ce-cli containerd.io -y
sudo yum install python3 python3-pip -y
sudo alternatives --set python /usr/bin/python3
sudo pip3 install docker-py 
sudo systemctl start docker
sudo systemctl enable docker
echo "license_key: eu01xxbc4708e1fdb63633cc49bb88b3ce5cNRAL" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install newrelic-infra -y
sudo usermod -aG docker ec2-user
docker pull hello-world
sudo hostnamectl set-hostname Docker
EOF

    tags = {
    Name = var.Docker_Server_Name
  }
}