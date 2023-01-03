variable "ami" {
  default = "ami-035c5dc086849b5de"
}
variable "instance_type" {
  default = "t2.medium"
}
variable "vpc_security_group_ids" {
  default = "sg-008291e750ad9bea8"
}

variable "subnet_id" {
  default = "subnet-0dfa85cd573b1898b"
}
variable "key_name" {
  default = "PACAAD1"
}
variable "path-to-publickey" {
  default     = "~/Keypairs/PACAAD1.pub"
  description = "this is the path to my pub key"
}

variable "iam_instance_profile" {
  default = "Ansible_IAM_instance_profile"
}

variable "Ansible_Node_Name" {
  default = "Ansible_Node"
}
