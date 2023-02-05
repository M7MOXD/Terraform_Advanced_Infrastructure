module "network" {
  source              = "./Network"
  my_vpc              = var.my_vpc
  my_public_subnet    = var.my_public_subnet
  my_private_subnet   = var.my_private_subnet
  my_route_cidr_block = var.my_route_cidr_block
}
module "sg" {
  source    = "./SG"
  my_vpc_id = module.network.my_vpc_id
}
module "lb" {
  source                = "./LB"
  my_vpc_id             = module.network.my_vpc_id
  my_public_subnet_ids  = module.network.my_public_subnet_ids
  my_public_lb_sg_id    = module.sg.my_public_lb_sg_id
  my_private_subnet_ids = module.network.my_private_subnet_ids
  my_private_lb_sg_id   = module.sg.my_private_lb_sg_id
}
module "ec2" {
  source                = "./EC2"
  my_ami_id             = data.aws_ami.my_ami.id
  my_public_ec2         = var.my_public_ec2
  my_private_ec2        = var.my_private_ec2
  my_public_subnet_ids  = module.network.my_public_subnet_ids
  my_private_subnet_ids = module.network.my_private_subnet_ids
  my_public_ec2_sg_id   = module.sg.my_public_ec2_sg_id
  my_private_ec2_sg_id  = module.sg.my_private_ec2_sg_id
  my_private_lb_dns     = module.lb.my_private_lb_dns
  my_key_name           = aws_key_pair.my_key.key_name
  my_public_lb_tg_arn   = module.lb.my_public_lb_tg_arn
  my_private_lb_tg_arn  = module.lb.my_private_lb_tg_arn
}