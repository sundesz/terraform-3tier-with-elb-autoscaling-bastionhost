# BASTION SERVER
resource "aws_instance" "bastion_server" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.settings.bastion_host.instance_type
  key_name                    = aws_key_pair.key_pair.key_name
  subnet_id                   = var.public_subnets[0]
  associate_public_ip_address = true
  security_groups             = [var.bastion_sg]

  tags = {
    Name = var.settings.bastion_host.name
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("${aws_key_pair.key_pair.key_name}.pem")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "${aws_key_pair.key_pair.key_name}.pem"
    destination = "/home/ec2-user/${aws_key_pair.key_pair.key_name}.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ec2-user/${aws_key_pair.key_pair.key_name}.pem"
    ]
  }
}