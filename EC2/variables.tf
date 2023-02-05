variable "my_ami_id" {
  type = string
}
variable "my_public_ec2" {
  type = list(map(string))
}
variable "my_private_ec2" {
  type = list(map(string))
}
variable "my_key_name" {
  type = string
}
variable "my_private_lb_dns" {
  type = string
}
variable "my_public_ec2_sg_id" {
  type = string
}
variable "my_private_ec2_sg_id" {
  type = string
}
variable "my_public_subnet_ids" {
  type = list(string)
}
variable "my_private_subnet_ids" {
  type = list(string)
}
variable "my_public_lb_tg_arn" {
  type = string
}
variable "my_private_lb_tg_arn" {
  type = string
}