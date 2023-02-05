variable "my_vpc_id" {
  type = string
}
variable "my_public_lb_sg_id" {
  type = string
}
variable "my_public_subnet_ids" {
  type = list(string)
}
variable "my_private_lb_sg_id" {
  type = string
}
variable "my_private_subnet_ids" {
  type = list(string)
}