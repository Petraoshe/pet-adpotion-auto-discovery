# Security_Group variables 
variable "JD_SG_name" {
    default = "JD_SG"
}
variable "BA_SG_name" {
    default = "BA_SG"
}
variable "DB_SG_name" {
    default = "DB_SG"
}
variable "Custom_http" {
    default = 8080
}
variable "ssh_port" {
    default = 22
}
variable "http_port" {
    default = 80
}

variable "mysql" {
    default = 3306
}
variable "vpc_cidr" {
    default     = "10.0.0.0/16"
    description = "PACAAD1_VPC"
}

  variable "all_cidr" {
    default     = "0.0.0.0/0"
    description = "PACAAD1_VPC"
}
variable "vpc_id" {
default = "vpc-0166902839c6ffb8c"
}
    

