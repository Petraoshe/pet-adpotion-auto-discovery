module "dev_vpc" {
  source       = "../../modules/vpc"
  VPC_cidr     = var.dev_vpc_cidr
  VPC_name     = var.dev_vpc_name
  PUB_SN1_cidr = var.dev_PUB_SN1_cidr
  PUB_SN2_cidr = var.dev_PUB_SN2_cidr
  PRV_SN1_cidr = var.dev_PRV_SN1_cidr
  PRV_SN2_cidr = var.dev_PRV_SN2_cidr
  PUB_SN1_name = var.dev_PUB_SN1_name
  PUB_SN2_name = var.dev_PUB_SN2_name
  PRV_SN1_name = var.dev_PRV_SN1_name
  PRV_SN2_name = var.dev_PRV_SN2_name
  all_cidr     = var.dev_all_cidr
  IGW_name     = var.dev_IGW_name
  EIP_name     = var.dev_EIP_name
  NAT_name     = var.dev_NAT_name
  PUB_RT_name  = var.dev_PUB_RT_name
  PRV_RT_name  = var.dev_PRV_RT_name
  az_A         = var.dev_az_A
  az_B         = var.dev_az_B
}
module "dev_Keypairs" {
  source            = "../../modules/Keypairs"
  path-to-publickey = var.dev_path-to-publickey
  key_name          = var.dev_key_name
}
module "dev_securitygroups" {
  source   = "../../modules/securitygroups"
  vpc_cidr = var.dev_vpc_cidr
  vpc_id   = module.dev_vpc.vpc_id
  all_cidr = var.dev_all_cidr
}

module "dev_iam" {
  source                            = "../../modules/iam"
  Ansible_IAM_role_Name             = var.dev_Ansible_IAM_role_Name
  Ansible_IAM_instance_profile_Name = var.dev_Ansible_IAM_instance_profile_Name
  Ansible_IAM_policy_Name           = var.dev_Ansible_IAM_policy_Name
}
module "dev_bastion" {
  source                      = "../../modules/bastion"
  ami                         = var.dev_instance_ami
  instance_type               = var.dev_instance_type
  subnet_id                   = module.dev_vpc.pubic_sn1_id
  vpc_security_group_ids      = module.dev_securitygroups.BA_SG_id
  key_name                    = var.dev_key_name
  associate_public_ip_address = var.dev_ass_pub_ip_address_bastion
  Bastion_Host_Name           = var.dev_Bastion_Host_Name
}

module "dev_docker" {
  source                 = "../../modules/docker"
  ami                    = var.dev_instance_ami
  instance_type          = var.dev_instance_type
  Subnet_id              = module.dev_vpc.private_sn1_id
  vpc_security_group_ids = module.dev_securitygroups.JD_SG_id
  key_name               = var.dev_key_name
  Docker_Server_Name     = var.dev_Docker_Server_Name
}

module "dev_jenkins" {
  source                 = "../../modules/jenkins"
  ami                    = var.dev_instance_ami
  instance_type          = var.dev_instance_type
  subnet_id              = module.dev_vpc.private_sn2_id
  vpc_security_group_ids = module.dev_securitygroups.JD_SG_id
  key_name               = var.dev_key_name
  Jenkins_Server_Name    = var.dev_Jenkins_Server_Name

}
module "dev_ansible" {
  source                 = "../../modules/ansible"
  ami                    = var.dev_instance_ami
  instance_type          = var.dev_instance_type
  subnet_id              = module.dev_vpc.private_sn1_id
  vpc_security_group_ids = module.dev_securitygroups.BA_SG_id
  key_name               = var.dev_key_name
  iam_instance_profile   = module.dev_iam.IAM_Instance_Profile_id
  Ansible_Node_Name      = var.dev_Ansible_Node_Name
}

module "dev_autoscaling" {
  source                 = "../../modules/autoscaling"
  image_id               = var.dev_instance_ami
  instance_type          = var.dev_instance_type
  vpc_security_group_ids = module.dev_securitygroups.JD_SG_id
  vpc_zone_identifier    = module.dev_vpc.private_sn1_id
  key_name               = var.dev_key_name
  ASG_tag_name           = var.dev_ASG_tag_name
  vpc_id                 = module.dev_vpc.vpc_id
  ASG_min_size           = var.dev_ASG_min_size
  ASG_max_size           = var.dev_ASG_max_size
  ASG_desired_capacity   = var.dev_ASG_desired_capacity
  target_group_arns      = module.dev_loadbalancer.target_group_arn
}
module "dev_loadbalancer" {
  source            = "../../modules/loadbalancer"
  jenkins-lb-name   = var.dev_jenkins-lb-name
  instance_type     = var.dev_instance_type
  securitygroup_id  = module.dev_securitygroups.JD_SG_id
  subnet_id1        = module.dev_vpc.pubic_sn1_id
  subnet_id2        = module.dev_vpc.public_sn2_id
  jenkins_server_id = module.dev_jenkins.Jenkins_Server_id
  docker-host-ami   = var.dev_instance_ami
  docker-lb-name    = var.dev_docker-lb-name
  docker-lb-tg-name = var.dev_docker-lb-tg-name
  vpc_id            = module.dev_vpc.vpc_id
  docker_target_id  = module.dev_docker.docker_id
}
module "dev_route53" {
  source          = "../../modules/route53"
  target_dns_name = module.dev_loadbalancer.target_dns_name
  target_zone_id  = module.dev_loadbalancer.target_zone_id
  Domain_name     = var.dev_Domain_name
}
