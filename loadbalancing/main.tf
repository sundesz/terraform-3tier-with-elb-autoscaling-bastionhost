# Create load balancer
resource "aws_lb" "my_lb" {
  name                      = "my-loadbalancer"
  internal                  = false
  load_balancer_type        = "application"
  security_groups           = [var.webserver_sg]
  subnets                   = var.public_subnets

  # An argument named "cross_zone_load_balancing" is not expected here.
  # cross_zone_load_balancing = true

  # Blocks of type "health_check" are not expected here.
  # health_check {
  #   healthy_threshold   = 2
  #   unhealthy_threshold = 2
  #   timeout             = 3
  #   interval            = 30
  #   target              = "HTTP:80/"
  #   # target              = "HTTP:8000/"
  # }

  depends_on = [
    var.webserver_asg
  ]
}

# Create Target group
resource "aws_lb_target_group" "my_tg" {
  name     = "my-lb-tg-${substr(uuid(), 0, 3)}"
  protocol = var.tg_protocol
  port     = var.tg_port
  vpc_id   = var.vpc_id
  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }
}

# Create load balancing listener
resource "aws_lb_listener" "my_lb_listener" {
  load_balancer_arn = aws_lb.my_lb.arn
  port              = var.listener_port
  protocol          = var.listener_protocol
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_tg.arn
  }
}