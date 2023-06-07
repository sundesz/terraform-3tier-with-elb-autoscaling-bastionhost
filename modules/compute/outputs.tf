output "webserver_asg" {
  value = aws_autoscaling_group.web_asg
}

output "bastion_ip" {
  value = aws_instance.bastion_server.public_ip
}