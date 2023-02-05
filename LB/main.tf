resource "aws_lb" "my_public_lb" {
  name               = "My-Public-LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.my_public_lb_sg_id]
  subnets            = [for subnet in var.my_public_subnet_ids : subnet]
}
resource "aws_lb_target_group" "my_public_lb_tg" {
  name     = "My-Public-LB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.my_vpc_id
}
resource "aws_lb_listener" "my_public_lb_listener" {
  load_balancer_arn = aws_lb.my_public_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_public_lb_tg.arn
  }
}
resource "aws_lb" "my_private_lb" {
  name               = "My-Private-LB"
  internal           = true
  load_balancer_type = "application"
  security_groups    = [var.my_private_lb_sg_id]
  subnets            = [for subnet in var.my_private_subnet_ids : subnet]
}
resource "aws_lb_target_group" "my_private_lb_tg" {
  name     = "My-Private-LB-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.my_vpc_id
}
resource "aws_lb_listener" "my_private_lb_listener" {
  load_balancer_arn = aws_lb.my_private_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.my_private_lb_tg.arn
  }
}