#### ANSIBLE Host Outputs

output "Ansible_node_id" {
  value = aws_instance.PACAAD1_Ansible_Node.id
}

output "Ansible_node_Prv_IP" {
  value = aws_instance.PACAAD1_Ansible_Node.private_ip
}