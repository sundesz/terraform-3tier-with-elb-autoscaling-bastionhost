# --- root/2_tier_architecture_Terraform_modules/loadbalancing/variables.tf ---

variable "public_subnets" {}
variable "vpc_id" {}
variable "webserver_sg" {}
variable "webserver_asg" {}



variable "tg_protocol" {
  default = "HTTP"
}

variable "tg_port" {
  default = 80
}

variable "listener_protocol" {
  default = "HTTP"
}

variable "listener_port" {
  default = 80
}