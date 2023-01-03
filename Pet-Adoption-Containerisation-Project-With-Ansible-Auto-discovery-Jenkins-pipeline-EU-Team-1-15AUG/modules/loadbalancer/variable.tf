variable "instance_type" {
    default = "t2.medium"
}
variable "securitygroup_id" {
   type = string
   default="sg-036254702898cb50c"
}
variable "subnet_id1" {
  type        = string
  default     = "subnet-76a8163a"
  description = "Subnet ID"
}
 variable "subnet_id2" {
  type        = string
  default     = "subnet-76a8163b"
  description = "Subnet ID"
}
variable "instance_id" {
    default = "i-0fc478dcb9081c543" 
}
variable "docker-host-ami" {
    default = "docker-host-ami"
}
variable "docker-asg-lc" {
    default = "docker-asg-lc"
}
variable "image_id" {
    default = "i-0fc478dcb9081c123"
}
variable "docker-lb-tg-name" {
    default = "PACADEU1-Docker-tg"
}
variable "jenkins-lb-tg-name" {
    default = "PACADEU1-Jenkins-tg"
}
variable "docker-lb-name" {
    default = "PACADEU1-docker-alb"
}
variable "jenkins-lb-name" {
    default = "PACADEU1-jenkins-lb"
}
variable "vpc_id" {
default = "vpc-0e956f11ebd3cd342"
}
variable "docker_target_id" {
    default = "i-0fc478dcb9081c456"
}
variable "jenkins_server_id" {
    default = "i-06c72421746eb9205"
}