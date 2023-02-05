resource "tls_private_key" "rsa_key" {
  algorithm = "RSA"
}
resource "local_file" "my_key_file" {
  content         = tls_private_key.rsa_key.private_key_pem
  filename        = "my_key.pem"
  file_permission = "0400"
}
resource "aws_key_pair" "my_key" {
  key_name   = "My_Key_Pair"
  public_key = tls_private_key.rsa_key.public_key_openssh
}