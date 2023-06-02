# Launch template for Web server
resource "aws_launch_template" "web_lt" {
  name_prefix            = "web-LT"
  image_id               = data.aws_ami.amazon_linux_2.id
  key_name               = aws_key_pair.key_pair.key_name
  instance_type          = var.ec2_instances.webserver.instance_type
  vpc_security_group_ids = [var.webserver_sg]
  user_data              = filebase64("${path.module}/userdata.sh")

  tags = {
    Name = var.ec2_instances.webserver.name
  }
}



# Autoscaling group Web server
resource "aws_autoscaling_group" "webserver_asg" {
  name                = "webserver-ASG"
  vpc_zone_identifier = var.public_subnets
  min_size            = 2
  max_size            = 3
  desired_capacity    = 2

  launch_template {
    id      = aws_launch_template.web_lt.id
    version = "$Latest"
  }

  health_check_type = "ELB"
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
  }

  tag {
    key                 = "Name"
    value               = "Web Server"
    propagate_at_launch = true
  }
}




# Auto Scaling Attachment resource.
resource "aws_autoscaling_attachment" "asg_attachment_bar" {
  autoscaling_group_name = aws_autoscaling_group.webserver_asg.id
  lb_target_group_arn    = var.alb_tg
}
