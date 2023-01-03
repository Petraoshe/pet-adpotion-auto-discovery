variable "ami" {
  default = "ami-035c5dc086849b5de"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "vpc_security_group_ids" {
    default = "sg-067477a8dc7c0ecff"
}
variable "subnet_id" {
    default = "subnet-0dfa85cd573b1898b"
}
variable "key_name" {
    default = "PACAAD1"
}
variable "path-to-publickey" {
  default     = "~/Keypairs/PACAAD1"
  description = "this is the path to my PRV key"
}

variable "Jenkins_Server_Name" {
    default = "Jenkins_Server"
}