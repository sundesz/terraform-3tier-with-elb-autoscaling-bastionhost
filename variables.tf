variable "aws_region" {
  default = "us-west-2"
  type    = string
}

variable "vpc_cidr" {
  type    = string
  default = "192.168.0.0/16"
}

variable "public_cidrs" {
  type    = list(string)
  default = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
}

variable "private_cidrs" {
  type    = list(string)
  default = ["192.168.11.0/24", "192.168.12.0/24", "192.168.13.0/24"]
}

variable "availability_zone" {
  type    = list(string)
  default = ["us-west-2a", "us-west-2b", "us-west-2c"]
}

variable "settings" {
  type = object({
    database = object({
      engine         = string
      engine_version = string
      instance_class = string
      identifier     = string
      db_name        = string
      username       = string
      password       = string
    })
  })

  default = {
    database = {
      engine         = "mysql"
      engine_version = "8.0"
      instance_class = "db.t3.micro"
      identifier     = "dbinstance"
      db_name        = "employees"
      username       = "main"
      password       = "lab-password"
    }
  }
}
