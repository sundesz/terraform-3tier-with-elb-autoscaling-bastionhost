# Web tier cup utilization up and down alarm
resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
  alarm_name          = "web_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"
  dimensions = {
    AutoScalingGroupName = var.web_asg_name
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [var.web_asg_policy_up_arn]
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
  alarm_name          = "web_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  dimensions = {
    AutoScalingGroupName = var.web_asg_name
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [var.web_asg_policy_down_arn]
}











# Application tier cup utilization up and down alarm
resource "aws_cloudwatch_metric_alarm" "app_cpu_alarm_up" {
  alarm_name          = "app_cpu_alarm_up"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "70"
  dimensions = {
    AutoScalingGroupName = var.app_asg_name
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [var.app_asg_policy_up_arn]
}



resource "aws_cloudwatch_metric_alarm" "app_cpu_alarm_down" {
  alarm_name          = "app_cpu_alarm_down"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "120"
  statistic           = "Average"
  threshold           = "30"
  dimensions = {
    AutoScalingGroupName = var.app_asg_name
  }
  alarm_description = "This metric monitor EC2 instance CPU utilization"
  alarm_actions     = [var.app_asg_policy_down_arn]
}