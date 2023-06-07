output "web_alb" {
  value = aws_lb.web_lb
}

output "web_alb_id" {
  value = aws_lb.web_lb.id
}

output "web_alb_tg" {
  value = aws_lb_target_group.web_lb_tg.arn
}

output "web_alb_dns" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.web_lb.dns_name
}


output "app_alb" {
  value = aws_lb.app_lb
}

output "app_alb_id" {
  value = aws_lb.app_lb.id
}

output "app_alb_tg" {
  value = aws_lb_target_group.app_lb_tg.arn
}

output "app_alb_dns" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.app_lb.dns_name
}