output "my_public_lb_dns" {
  value = aws_lb.my_public_lb.dns_name
}
output "my_public_lb_tg_arn" {
  value = aws_lb_target_group.my_public_lb_tg.arn
}
output "my_private_lb_dns" {
  value = aws_lb.my_private_lb.dns_name
}
output "my_private_lb_tg_arn" {
  value = aws_lb_target_group.my_private_lb_tg.arn
}