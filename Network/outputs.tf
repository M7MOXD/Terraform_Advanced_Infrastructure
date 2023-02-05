output "my_vpc_id" {
  value = aws_vpc.my_vpc.id
}
output "my_public_subnet_ids" {
  value = aws_subnet.my_public_subnet[*].id
}
output "my_private_subnet_ids" {
  value = aws_subnet.my_private_subnet[*].id
}