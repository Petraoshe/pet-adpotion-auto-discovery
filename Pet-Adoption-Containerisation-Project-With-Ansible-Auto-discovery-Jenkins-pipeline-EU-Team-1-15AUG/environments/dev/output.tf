output "Bastion-Host-Public-IP" {
  value = module.dev_bastion.Bastion_public_ip
}

output "IAM_id" {
  value = module.dev_iam.IAM_Instance_Profile_id
}

output "Ansible-Node-IP" {
  value = module.dev_ansible.Ansible_node_Prv_IP
}

output "Jenkins-Host-IP" {
  value = module.dev_jenkins.Jenkins_node_Prv_IP
}

output "Docker-Host-IP" {
  value = module.dev_docker.Docker_Prv_IP
}
output "route53_dns" {
  value = module.dev_route53.Name_Servers
}
output "Jenkins_lb_dns" {
  value = module.dev_loadbalancer.jenkins_lb_dns_name
}
output "Docker_lb_dns" {
  value = module.dev_loadbalancer.target_dns_name
}