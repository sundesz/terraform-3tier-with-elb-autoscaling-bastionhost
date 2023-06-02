# Create subnet
resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = var.public_cidrs[0]
  availability_zone       = var.availability_zone[0]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "public_subnet_1b" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = element(var.public_cidrs, 1)
  availability_zone       = var.availability_zone[1]
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet_1a" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = element(var.private_cidrs, 0)
  availability_zone = var.availability_zone[0]
}

resource "aws_subnet" "private_subnet_1b" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = element(var.private_cidrs, 1)
  availability_zone = var.availability_zone[1]
}