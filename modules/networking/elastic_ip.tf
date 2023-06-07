# Create Elastic IP for the EC2 instance
resource "aws_eip" "eip" {
  vpc = true
  tags = {
    Name = "eip"
  }
}


# Associate Elastic IP to Server
# resource "aws_eip_association" "eip-association" {
#   instance_id   = aws_instance.web_server.id
#   allocation_id = aws_eip.eip.id
# }
