resource "random_integer" "random" {
  min = 1
  max = 100
}

# Autoscaling group for Web server
resource "aws_autoscaling_group" "web_asg" {
  name                = "webserver-ASG"
  vpc_zone_identifier = var.public_subnets
  min_size            = 1
  max_size            = 4
  desired_capacity    = 1

  launch_template {
    id      = aws_launch_template.webserver_lt.id
    version = "$Latest"
  }

  health_check_grace_period = 300
  health_check_type         = "ELB" // or "EC2"

  # load_balancers = [
  #   "${aws_elb.web_elb.id}"
  # ]
  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [load_balancers, target_group_arns]

  }

  tag {
    key                 = "Name"
    value               = "Web Server - ${random_integer.random.id}"
    propagate_at_launch = true
  }
}


# ALB Target Group attachment
resource "aws_autoscaling_attachment" "web_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.web_asg.id
  lb_target_group_arn    = var.web_alb_tg
}






# Autoscaling group for APP server
resource "aws_autoscaling_group" "app_asg" {
  name                = "appserver-ASG"
  vpc_zone_identifier = var.public_subnets
  min_size            = 1
  max_size            = 4
  desired_capacity    = 1

  launch_template {
    id      = aws_launch_template.appserver_lt.id
    version = "$Latest"
  }

  health_check_grace_period = 300
  health_check_type         = "ELB" // or "EC2"

  # load_balancers = [
  #   "${aws_elb.app_elb.id}"
  # ]

  enabled_metrics = [
    "GroupMinSize",
    "GroupMaxSize",
    "GroupDesiredCapacity",
    "GroupInServiceInstances",
    "GroupTotalInstances"
  ]
  metrics_granularity = "1Minute"

  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [load_balancers, target_group_arns]

  }

  tag {
    key                 = "Name"
    value               = "App Server - ${random_integer.random.id}"
    propagate_at_launch = true
  }
}


# ALB Target Group attachment
resource "aws_autoscaling_attachment" "app_asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.app_asg.id
  lb_target_group_arn    = var.app_alb_tg
}
