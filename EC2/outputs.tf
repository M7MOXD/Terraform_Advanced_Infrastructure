output "my_public_ec2_ip" {
  value = aws_instance.my_public_ec2[*].public_ip
}
output "my_private_ec2_ip" {
  value = aws_instance.my_private_ec2[*].private_ip
}