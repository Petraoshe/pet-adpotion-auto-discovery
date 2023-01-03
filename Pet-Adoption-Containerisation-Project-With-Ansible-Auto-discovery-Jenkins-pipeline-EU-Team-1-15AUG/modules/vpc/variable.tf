variable "VPC_cidr" {
  default = "10.0.0.0/16"
}

variable "VPC_name" {
  default = "PACAAD1_VPC"
}
variable "PUB_SN1_cidr" {
  default = "10.0.1.0/24"
}

variable "PUB_SN2_cidr" {
  default = "10.0.2.0/24"
}

variable "PRV_SN1_cidr" {
  default = "10.0.3.0/24"
}

variable "PRV_SN2_cidr" {
  default = "10.0.4.0/24"
}
variable "PUB_SN1_name" {
  default = "PACAAD1_PUB_SN1"
}
variable "PUB_SN2_name" {
  default = "PACAAD1_PUB_SN2"
}
variable "PRV_SN1_name" {
  default = "PACAAD1_PRV_SN1"
}
variable "PRV_SN2_name" {
  default = "PACAAD1_PRV_SN2"
}
variable "all_cidr" {
  default = "0.0.0.0/0"
}
variable "keypair_name" {
  default     = "PACAAD1"
  description = "keypair name"
}
variable "path-to-publickey" {
  default     = "~/Keypairs/PACAAD1.pub"
  description = "this is path to the keypair in our local machine"
}
variable "IGW_name" {
  default = "PACAAD1_IGW"
}
variable "EIP_name" {
  default = "PACAAD1_EIP"
}
variable "NAT_name" {
  default = "PACAAD1_NAT_GW"
}
variable "PUB_RT_name" {
  default = "PACAAD1_PUB_RT"
}
variable "PRV_RT_name" {
  default = "PACAAD1_PRV_RT"
}
variable "az_A" {
  default = "eu-west-1a"
}
variable "az_B" {
  default = "eu-west-1b"
}