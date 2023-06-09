variable "aws_region" {
  default = "eu-north-1"
  type    = string
}

variable "vpc_cidr" {
  default = "192.168.0.0/16"
}

variable "public_cidrs" {
  default = ["192.168.1.0/24", "192.168.2.0/24"]
  type    = list(string)
}

variable "private_cidrs" {
  default = ["192.168.51.0/24", "192.168.52.0/24"]
  type    = list(string)
}

variable "availability_zones" {
  default = ["eu-north-1a", "eu-north-1b"]
  type    = list(string)
}


# This variable contains the configuration settings for the EC2s and RDS instances

variable "settings" {
  type = object({
    bastion_host = object({
      name          = string
      instance_type = string
    })
    web_server = object({
      name          = string
      instance_type = string
    })
    app_server = object({
      name          = string
      instance_type = string
    })
    database_instance = object({
      allocated_storage   = number
      engine              = string
      engine_version      = string
      instance_class      = string
      identifier          = string
      db_name             = string
      username            = string
      password            = string
      skip_final_snapshot = bool
    })
  })

  default = {
    bastion_host = {
      name          = "Bastion host"
      instance_type = "t3.micro"
    }
    web_server = {
      name          = "Web server"
      instance_type = "t3.micro"
    }
    app_server = {
      name          = "Application server"
      instance_type = "t3.micro"
    }
    database_instance = {
      allocated_storage = 10
      engine            = "mysql"
      engine_version    = "8.0"
      instance_class    = "db.t3.micro"
      identifier        = "dbinstance"
      db_name           = "employees"
      username          = "main"
      password          = "lab-password"

      skip_final_snapshot = true
    }
  }
}

variable "sns_email" {
  type = string
}