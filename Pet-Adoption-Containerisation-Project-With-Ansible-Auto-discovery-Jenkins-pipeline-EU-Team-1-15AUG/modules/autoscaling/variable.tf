variable "instance_type" {
    default = "t2.medium"
}
variable "name_prefix_lc" {
  default = "PACADEU1-lc"
}
variable "name_asg" {
  default = "PACADEU1-asg"
}
variable "vpc_security_group_ids" {
   type = string
   default="sg-036254702898cb50c"
}
variable "ASG_tag_name" {
   type = string
   default="PACADEU1_Docker_ASG"
}
variable "ASG_policy_name" {
   type = string
   default="PACADEU1-asg-pol"
}
variable "subnet_id" {
  type        = string
  default     = "subnet-76a8163a"
  description = "Subnet ID"
}
variable "key_name" {
    default = "pacaad1"  
}
variable "Docker_Host_id" {
    default = "i-0fc478dcb9081c543" 
}
variable "docker-asg-lc" {
    default = "docker-asg-lc"
}
variable "image_id" {
    default = "i-0fc478dcb9081c123"
}
variable "Docker-ASG-Name" {
    default = "Docker-ASG"
}
variable "ASG_min_size" {
    default = 2
}
variable "ASG_max_size" {
    default = 3
}
variable "ASG_desired_capacity" {
    default = 2
}
variable "health_check_grace_period" {
    default = 300 
}
variable "target_group_arns" {
 default = "arn:aws:elasticloadbalancing:eu-west-1"
}
variable "health_check_type" {
    default = "EC2"
}
variable "vpc_zone_identifier" {
    type        = string
    default     = "subnet-76a8123a"
    description = "Subnet ID" 
}
variable "vpc_id" {
default = "vpc-0e956f11ebd3cd342"
}
variable "target_value" {
  default = "60"
}