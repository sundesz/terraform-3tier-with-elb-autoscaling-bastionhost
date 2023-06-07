resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.public_cidrs[0]
  availability_zone       = var.availability_zones[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1a"
  }
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id                  = var.vpc_id
  cidr_block              = element(var.public_cidrs, 1)
  availability_zone       = var.availability_zones[1]
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-1b"
  }
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id            = var.vpc_id
  cidr_block        = element(var.private_cidrs, 0)
  availability_zone = var.availability_zones[0]

  tags = {
    Name = "private-subnet-1a"
  }
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id            = var.vpc_id
  cidr_block        = element(var.private_cidrs, 1)
  availability_zone = var.availability_zones[1]

  tags = {
    Name = "private-subnet-1b"
  }
}