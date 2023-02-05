output "my_public_lb_sg_id" {
  value = aws_security_group.my_public_lb_sg.id
}
output "my_private_lb_sg_id" {
  value = aws_security_group.my_private_lb_sg.id
}
output "my_public_ec2_sg_id" {
  value = aws_security_group.my_public_ec2_sg.id
}
output "my_private_ec2_sg_id" {
  value = aws_security_group.my_private_ec2_sg.id
}