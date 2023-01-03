
################################################################################
# ANSIBLE SERVER
################################################################################
# Provision Ansible Host
resource "aws_instance" "PACAAD1_Ansible_Node" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.vpc_security_group_ids]
  associate_public_ip_address = false
  iam_instance_profile        = var.iam_instance_profile
 user_data                   = <<-EOF
#!/bin/bash
sudo yum update -y
sudo yum install python3 python3-pip -y
sudo alternatives --set python /usr/bin/python3
sudo pip3 install docker-py
sudo yum install ansible -y
sudo yum install -y yum-utils -y
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install docker-ce -y
sudo systemctl start docker
sudo systemctl enable docker
cd /etc/ansible
sudo yum install unzip -y
sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
sudo unzip awscliv2.zip
sudo ./aws/install
./aws/install -i /usr/local/aws-cli -b /usr/local/bin
sudo ./aws/install --bin-dir /usr/local/bin --install-dir /usr/local/aws-cli --update
sudo ln -svf /usr/local/bin/aws /usr/bin/aws
sudo yum install vim -y
sudo chown -R ec2-user:ec2-user /etc/ansible && chmod +x /etc/ansible/discovery.sh
echo "license_key: eu01xxbc4708e1fdb63633cc49bb88b3ce5cNRAL" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/amazonlinux/2/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install newrelic-infra -y
sudo su
echo Admin123@ | passwd ec2-user --stdin
echo "ec2-user ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
sed -ie 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo service sshd reload
sudo chmod -R 700 .ssh/
sudo chown -R ec2-user:ec2-user .ssh/
sudo bash -c ' echo "StrictHostKeyChecking No" >> /etc/ssh/ssh_config'
ssh-copy-id -i /home/ec2-user/.ssh/anskey.pub ec2-user@localhost -p 22
cd /etc
sudo chown ec2-user:ec2-user hosts
sudo chmod 700 -R /etc/ansible/
touch /etc/ansible/MyPlaybook.yaml
cat <<EOT>> /etc/ansible/MyPlaybook.yaml
---
- hosts: webservers
  become: true
  vars:
    create_containers: 1
    default_container_name: my-app
    default_container_image: cloudhight/pipeline:1.0.0
    default_container_command: sleep 1d
    default_container_port: 8085
    defaul_host_port: 8080

  tasks:
   - name: login to dockerhub
     command: docker login -u cloudhight -p CloudHight_Admin123@

   - name: Stop any container running
     command: docker stop pet-adoption-container
     ignore_errors: yes

   - name: Remove stopped container
     command: docker rm pet-adoption-container
     ignore_errors: yes

   - name: Remove docker image
     command: docker rmi cloudhight/pipeline:1.0.0
     ignore_errors: yes
  tasks:
    - name: Pull default Docker image
      docker_image:
        name: "{{ default_container_image }}"
        source: pull

    - name: Restart a container
      docker_container:
        name: pet-adoption-container
        image: cloudhight/pipeline:1.0.0
        state: started
        ports:
         - "8080:8085"
EOT
touch /etc/ansible/discovery.sh
cat <<EOT>> /etc/ansible/discovery.sh
#!/bin/bash
# This script automatically update ansible host inventory
#!/bin/bash
# This script automatically update ansible host inventory

TAG='Tomcat-test'
AWSBIN='/usr/local/bin/aws'
awsDiscovery() {
	\$AWSBIN ec2 describe-instances --filters Name=tag:aws:autoscaling:groupName,Values=dockerHostASG \
		--query Reservations[*].Instances[*].NetworkInterfaces[*].{PrivateIpAddresses:PrivateIpAddress} > /etc/ansible/ips.list
	}
inventoryUpdate() {
	echo > /etc/ansible/hosts 
  	echo [webservers] > /etc/ansible/hosts
	for instance in `cat /etc/ansible/ips.list`
	do
		ssh-keyscan -H \$instance >> ~/.ssh/known_hosts
echo "
\$instance ansible_user=ec2-user ansible_ssh_private_key_file=/etc/ansible/anskey.pem
" >> /etc/ansible/hosts
       done
}
instanceUpdate() {
  sleep 30
  ansible-playbook MyPlaybook.yaml 
  sleep 30
}

awsDiscovery
inventoryUpdate
#instanceUpdate#!/bin/bash
EOT

sudo hostnamectl set-hostname Ansible
EOF
  tags = {
    Name = var.Ansible_Node_Name
  }
}

