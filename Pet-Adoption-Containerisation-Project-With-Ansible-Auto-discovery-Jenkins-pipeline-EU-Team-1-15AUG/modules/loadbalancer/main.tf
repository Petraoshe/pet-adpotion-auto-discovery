#Add an Jenkins Load Balancer
resource "aws_elb" "PACADEU1-jenkins-lb" {
  name            = var.jenkins-lb-name
  subnets         = [var.subnet_id2]
  security_groups = [var.securitygroup_id]

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "TCP:8080"
    interval            = 30
  }

  instances                   = [var.jenkins_server_id]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = var.jenkins-lb-tg-name
  }
}

# #Create Target group attachment for Jenkins lb
# resource "aws_lb_target_group_attachment" "PACADEU1-tg-jk-att" {
#   target_group_arn = aws_lb_target_group.PACADEU1-tg-jk.arn
#   target_id        = var.jenkins_server_id
#   port             = 8080
# }

#Add an Application Load Balancer
resource "aws_lb" "PACADEU1-docker-alb" {
  name                       = var.docker-lb-name
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.securitygroup_id]
  subnets                    = [var.subnet_id1,var.subnet_id2]
  enable_deletion_protection = false
}
#Add a load balancer Listener
resource "aws_lb_listener" "PACADEU1-lb-listener" {
  load_balancer_arn = aws_lb.PACADEU1-docker-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.PACADEU1-tg.arn
  }
}
# Create a Target Group for application Load Balancer
resource "aws_lb_target_group" "PACADEU1-tg" {
  name     = var.docker-lb-tg-name
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 5
    interval            = 30
    timeout             = 5
    path                = "/"
  }
}

#Create a Target Group for Jenkins Load Balancer
resource "aws_lb_target_group" "PACADEU1-Jenkins-tg" {
  name     = var.jenkins-lb-tg-name
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 5
    interval            = 30
    timeout             = 5
    path                = "/"
  }
}

#Create Target group attachment for application lb
resource "aws_lb_target_group_attachment" "PACADEU1-tg-att" {
  target_group_arn = aws_lb_target_group.PACADEU1-tg.arn
  target_id        = var.docker_target_id
  port             = 8080
}
