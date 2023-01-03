
output "Bastion_public_ip" {
    value = aws_instance.Bastion_Host.public_ip
}