variable "bastion_host_sg" {}
variable "webserver_sg" {}
variable "rds_sg" {}
variable "private_subnets" {}
variable "public_subnets" {}
variable "elb" {}
variable "alb_tg" {}


variable "ec2_instances" {
  type = object({
    bastion_host = object({
      name          = string
      instance_type = string
    })
    webserver = object({
      name          = string
      instance_type = string
    })
  })

  default = {
    bastion_host = {
      name          = "Bastion host"
      instance_type = "t3.micro"
    }
    webserver = {
      name          = "Web server"
      instance_type = "t3.micro"
    }
  }
}
