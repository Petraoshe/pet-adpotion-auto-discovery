# VPC Related Variables
variable "dev_vpc_name" {
  default = "EUTeam1_VPC"
}
variable "dev_az_A" {
  default = "eu-west-1a"
}
variable "dev_vpc_cidr" {
  default = "30.0.0.0/16"
}
variable "dev_PUB_SN1_cidr" {
  default = "30.0.1.0/24"
}
variable "dev_PUB_SN2_cidr" {
  default     = "30.0.2.0/24"
  description = "PACAAD1_PUB_SN2"
}
variable "dev_PRV_SN1_cidr" {
  default = "30.0.3.0/24"
}
variable "dev_PRV_SN2_cidr" {
  default = "30.0.4.0/24"
}
variable "dev_PRV_SN3_cidr" {
  default = "30.0.5.0/24"
}

variable "dev_PRV_SN4_cidr" {
  default = "30.0.6.0/24"
}
variable "dev_az_B" {
  default = "eu-west-1b"
}
variable "dev_PUB_SN1_name" {
  default = "EUteam1_PubSN1"
}
variable "dev_PUB_SN2_name" {
  default = "EUteam1_PubSN2"
}
variable "dev_PRV_SN1_name" {
  default = "EUteam1_PrvSN1"
}
variable "dev_PRV_SN2_name" {
  default = "EUteam1_PrvSN2"
}
variable "dev_EIP_name" {
  default = "EUTeam1_EIP"
}
variable "dev_IGW_name" {
  default = "EUTeam1_IGW"
}
variable "dev_NAT_name" {
  default = "EUTeam1_NAT"
}
variable "dev_PUB_RT_name" {
  default = "EUTeam1_RT_Pub"
}
variable "dev_PRV_RT_name" {
  default = "EUTeam1_RT_Prv"
}
variable "dev_all_cidr" {
  default = "0.0.0.0/0"
}
variable "dev_path-to-publickey" {
  default     = "~/Keypairs/PACAAD1.pub"
  description = "this is the path to my pub key"
}
variable "dev_key_name" {
  default = "PACAAD1"
}
variable "dev_instance_ami" {
  default     = "ami-0f0f1c02e5e4d9d9f" #ami for eu-west-1
  description = "AMI for the Servers"
}
variable "dev_instance_type" {
  default     = "t2.medium"
  description = "EC2 instance type for the Servers"
}
variable "dev_ass_pub_ip_address_bastion" {
  type        = bool
  default     = true
  description = "public ip address attachment to the instance"
}
variable "dev_Bastion_Host_Name" {
  type    = string
  default = "Bastion_Host"
}
variable "dev_Ansible_Node_Name" {
  type        = string
  default     = "Ansible_Node"
  description = "Name Tag for Ansible Node"
}
variable "dev_Ansible_IAM_role_Name" {
  default = "EUTeam1_Ansible_IAM_role"
}
variable "dev_Ansible_IAM_instance_profile_Name" {
  default = "EUTeam1_Ansible_IAM_instance_profile"
}
variable "dev_Ansible_IAM_policy_Name" {
  default = "EUTeam1_Ansible_IAM_policy"
}
variable "dev_Docker_Server_Name" {
  type        = string
  default     = "EUTeam1_Docker_Host"
  description = "Name Tag for Docker Server"
}
variable "dev_Jenkins_Server_Name" {
  type    = string
  default = "EUTeam1_Jenkins_Server"
}
variable "dev_name_prefix" {
  default = "EUTeam1_Docker_lc"
}
variable "dev_ASG_tag_name" {
  default = "EUTeam1_Docker_ASG"
}
variable "dev_jenkins-lb-name" {
  default = "EUTeam1-Jenkins-LB"
}
variable "dev_docker-lb-name" {
  default = "EUTeam1-Docker-LB"
}
variable "dev_docker-lb-tg-name" {
  default = "EUTeam1-Docker-LB-TG"
}

# variable "dev_instance_type" {
#   default     = "t2.medium"
#   description = "EC2 instance type for the Servers"
# }
# variable "dev_ass_pub_ip_address_bastion" {
#   type        = bool
#   default     = true
#   description = "public ip address attachment to the instance"
# }
# variable "dev_ass_pub_ip_address_servers" {
#   type        = bool
#   default     = false
#   description = "public ip address attachment to the instance"
# }


# variable "dev_Ansible_Node_Name" {
#   type        = string
#   default     = "Ansible_Node"
#   description = "Name Tag for Ansible Node"
# }

# Security_Group variables 
variable "dev_JD_SG_name" {
  default = "dev_JD_SG"
}
variable "dev_BA_SG_name" {
  default = "dev_BA_SG"
}
variable "dev_Domain_name" {
  default = "alexdevs.link"
}

# variable "dev_Custom_http" {
#   default = 8080
# }
# variable "dev_ssh_port" {
#   default = 22
# }
# variable "dev_http_port" {
#   default = 80
# }

# variable "dev_mysql" {
#   default = 3306
# }
# variable "dev_all_cidr" {
#   default     = "0.0.0.0/0"
#   description = "PACAAD1_VPC"
# }
# variable "dev_key_name" {
#   default = "pacaad1"
# }
# variable "dev_path_to_public_key" {
#   default     = "~/keypairs/pacaad1.pub"
#   description = "path to public key"
# }
# ######################################
# # Autoscaling variable
# variable "dev_Docker_Host_id" {
#     default = "i-0fc478dcb9081c543" 
# }
# variable "dev_docker-host-ami" {
#     default = "docker-host-ami"
# }
# variable "dev_docker-asg-lc" {
#     default = "docker-asg-lc"
# }
# variable "dev_image_id" {
#     default = "i-0fc478dcb9081c123"
# }

variable "dev_ASG_min_size" {
  default = 2
}
variable "dev_ASG_max_size" {
  default = 3
}
variable "dev_ASG_desired_capacity" {
  default = 2
}
variable "dev_health_check_grace_period" {
  default = 300
}
variable "dev_health_check_type" {
  default = "EC2"
}
