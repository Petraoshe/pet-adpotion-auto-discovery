# #Docker-launch-configuration
resource "aws_launch_configuration" "PACADEU1-lc" {
  name_prefix                 = var.name_prefix_lc
  image_id                    = var.image_id
  instance_type               = var.instance_type
  security_groups             = [var.vpc_security_group_ids]
  associate_public_ip_address = false
  key_name                    = var.key_name
user_data                   = <<-EOF
#!/bin/bash
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum update -y
sudo yum install docker-ce docker-ce-cli containerd.io -y
sudo yum install python3 python3-pip -y
sudo alternatives --set python /usr/bin/python3
sudo pip3 install docker-py
sudo systemctl start docker
sudo systemctl enable docker
echo "license_key: 18b989848e83ee998df70e98b20b815c02b0NRAL" | sudo tee -a /etc/newrelic-infra.yml
sudo curl -o /etc/yum.repos.d/newrelic-infra.repo https://download.newrelic.com/infrastructure_agent/linux/yum/el/7/x86_64/newrelic-infra.repo
sudo yum -q makecache -y --disablerepo='*' --enablerepo='newrelic-infra'
sudo yum install newrelic-infra -y
sudo hostnamectl set-hostname dockerHostASG
  EOF

}

#Creating Autoscaling Group 
resource "aws_autoscaling_group" "PACADEU1-asg" {
  name                      = var.name_asg
  desired_capacity          = var.ASG_desired_capacity
  max_size                  = var.ASG_max_size
  min_size                  = var.ASG_min_size
  health_check_grace_period = var.health_check_grace_period
  health_check_type         = var.health_check_type
  force_delete              = true
  launch_configuration      = aws_launch_configuration.PACADEU1-lc.name
  vpc_zone_identifier       = [var.vpc_zone_identifier]
  target_group_arns         = [var.target_group_arns]
  tag {
    key                 = "Name"
    value               = var.ASG_tag_name
    propagate_at_launch = true
  }
}

#Creating Autoscaling Policy   
resource "aws_autoscaling_policy" "PACADEU1-asg-pol" {
  name                   = var.ASG_policy_name
  policy_type            = "TargetTrackingScaling"
  adjustment_type        = "ChangeInCapacity"
  autoscaling_group_name = aws_autoscaling_group.PACADEU1-asg.name
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.target_value
  }
}