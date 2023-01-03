output "target_group_arn" {
  value=aws_lb_target_group.PACADEU1-tg.arn
}
output "target_dns_name" {
  value=aws_lb.PACADEU1-docker-alb.dns_name
}
output "jenkins_lb_dns_name" {
  value=aws_elb.PACADEU1-jenkins-lb.dns_name
}
output "target_zone_id" {
  value=aws_lb.PACADEU1-docker-alb.zone_id
}