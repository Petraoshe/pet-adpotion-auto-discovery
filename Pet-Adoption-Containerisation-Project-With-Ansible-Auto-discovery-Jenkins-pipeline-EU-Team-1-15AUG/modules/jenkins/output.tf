output "Jenkins_Server_id" {
  value = aws_instance.Jenkins_Server.id
}

output "Jenkins_node_Prv_IP" {
  value = aws_instance.Jenkins_Server.private_ip
}
