output "webserver_asg" {
  value = aws_autoscaling_group.web_asg
}

output "web_asg_name" {
  value = aws_autoscaling_group.web_asg.name
}

output "web_asg_policy_up_arn" {
  value = aws_autoscaling_policy.web_policy_up.arn
}

output "web_asg_policy_down_arn" {
  value = aws_autoscaling_policy.web_policy_down.arn
}

output "app_asg_name" {
  value = aws_autoscaling_group.app_asg.name
}

output "app_asg_policy_up_arn" {
  value = aws_autoscaling_policy.app_policy_up.arn
}

output "app_asg_policy_down_arn" {
  value = aws_autoscaling_policy.app_policy_down.arn
}

output "bastion_ip" {
  value = aws_instance.bastion_server.public_ip
}