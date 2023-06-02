# BASTION SERVER
resource "aws_instance" "bastion_server" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.ec2_instances.bastion_host.instance_type
  key_name                    = aws_key_pair.key_pair.key_name
  subnet_id                   = var.public_subnets[0]
  associate_public_ip_address = true
  security_groups             = [var.bastion_host_sg]

  tags = {
    Name = var.ec2_instances.bastion_host.name
  }
}