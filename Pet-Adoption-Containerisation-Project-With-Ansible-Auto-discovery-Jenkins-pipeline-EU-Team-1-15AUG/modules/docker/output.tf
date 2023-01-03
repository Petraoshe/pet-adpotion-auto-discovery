output "docker_id" {
  value = aws_instance.PACAAD1-Docker-Host.id
}
output "Docker_Prv_IP" {
  value = aws_instance.PACAAD1-Docker-Host.private_ip
}
output "Docker_ami" {
  value = aws_instance.PACAAD1-Docker-Host.ami
}
