variable "dbEndpoint" {}
variable "db_instance" {}
variable "private_subnets" {}
variable "public_subnets" {}
variable "bastion_sg" {}
variable "rds_sg" {}

variable "web_sg" {}
variable "web_alb" {}
variable "web_alb_tg" {}

variable "app_sg" {}
variable "app_alb" {}
variable "app_alb_tg" {}
variable "app_alb_dns" {}

variable "settings" {}