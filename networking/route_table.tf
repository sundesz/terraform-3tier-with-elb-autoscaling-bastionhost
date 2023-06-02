
# Create Public Route Table
resource "aws_route_table" "public_RT" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Associate subnet with public Route Table
resource "aws_route_table_association" "public_route_a" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.public_RT.id
}
resource "aws_route_table_association" "public_route_b" {
  subnet_id      = aws_subnet.public_subnet_1b.id
  route_table_id = aws_route_table.public_RT.id
}



# Create Private Route Table
resource "aws_route_table" "private_RT" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.natgw.id
  }
}

# Associate subnet with public Route Table
resource "aws_route_table_association" "private_route_a" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.private_RT.id
}
resource "aws_route_table_association" "private_route_b" {
  subnet_id      = aws_subnet.private_subnet_1b.id
  route_table_id = aws_route_table.private_RT.id
}
