variable "ami" {
    default = "ami-0f0f1c02e5e4d9d9f"
}
variable "instance_type" {
    default = "t2.micro"
}
variable "vpc_security_group_ids" {
    default = "sg-0102fd013346e351e"
}
variable "subnet_id" {
    default = "subnet-76a8163a"
}
variable "key_name" {
    default = "PACAAD1"
}
variable "path-to-publickey" {
  default     = "~/Keypairs/PACAAD1.pub"
  description = "this is the path to my pub key"
}
variable "Bastion_Host_Name" {
  default   =  "Bastion_Host"
}
variable "associate_public_ip_address" {
  type   = bool
  default = true
}