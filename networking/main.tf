resource "random_integer" "random" {
  min = 1
  max = 100
}

# VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "my_vpc-${random_integer.random.id}"
  }
}