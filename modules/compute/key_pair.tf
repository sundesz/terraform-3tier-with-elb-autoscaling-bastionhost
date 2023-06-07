# Private Key and Keypair
## Create a key with RSA algorithm with 4096 rsa bits
resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

## Create a key pair using above private key
resource "aws_key_pair" "key_pair" {
  key_name   = "aws_test_key"
  public_key = tls_private_key.private_key.public_key_openssh

  depends_on = [tls_private_key.private_key]
}

## Save the private key at the specified path
# resource "local_file" "save-key" {
resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.key_pair.key_name}.pem"
  content  = tls_private_key.private_key.private_key_pem

  provisioner "local-exec" {
    command = "chmod 400 ${aws_key_pair.key_pair.key_name}.pem"
  }
}