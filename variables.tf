variable "my_vpc" {
  type = map(string)
}
variable "my_public_subnet" {
  type = list(map(string))
}
variable "my_private_subnet" {
  type = list(map(string))
}
variable "my_route_cidr_block" {
  type = string
}
variable "my_public_ec2" {
  type = list(map(string))
}
variable "my_private_ec2" {
  type = list(map(string))
}