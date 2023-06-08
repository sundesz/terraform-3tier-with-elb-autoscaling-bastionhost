# Create a load balancer, listener, and target group for WEB tier


# Create load balancer
resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_web_sg]
  subnets            = var.public_subnets

  enable_deletion_protection = false
}

# Create Target group
# Create a target group, which is used in request routing.
# The default rule for your listener routes requests to the registered targets in this target group.
# The load balancer checks the health of targets in this target group using the health check settings defined for the target group.
resource "aws_lb_target_group" "web_lb_tg" {
  name     = "web-LB-TG-${substr(uuid(), 0, 3)}"
  protocol = "HTTP"
  port     = 80
  vpc_id   = var.vpc_id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }
}

# Create load balancing listener
resource "aws_lb_listener" "web_lb_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_lb_tg.arn
  }
}




# Create a load balancer, listener, and target group for APPLICATION tier


# Create load balancer
resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_app_sg]
  subnets            = var.public_subnets

  enable_deletion_protection = false
}

# Create Target group
resource "aws_lb_target_group" "app_lb_tg" {
  name     = "app-LB-TG-${substr(uuid(), 0, 3)}"
  protocol = "HTTP"
  port     = 8080
  vpc_id   = var.vpc_id

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [name]
  }
}

# Create load balancing listener
resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 8080
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_lb_tg.arn
  }
}