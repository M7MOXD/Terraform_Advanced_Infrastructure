resource "aws_vpc" "my_vpc" {
  cidr_block = var.my_vpc["cidr_block"]
  tags = {
    "Name" = var.my_vpc["tag_name"]
  }
}
resource "aws_subnet" "my_public_subnet" {
  count                   = length(var.my_public_subnet)
  vpc_id                  = aws_vpc.my_vpc.id
  availability_zone       = var.my_public_subnet[count.index]["availability_zone"]
  cidr_block              = var.my_public_subnet[count.index]["cidr_block"]
  map_public_ip_on_launch = true
  tags = {
    Name = var.my_public_subnet[count.index]["tag_name"]
  }
}
resource "aws_subnet" "my_private_subnet" {
  count                   = length(var.my_private_subnet)
  vpc_id                  = aws_vpc.my_vpc.id
  availability_zone       = var.my_private_subnet[count.index]["availability_zone"]
  cidr_block              = var.my_private_subnet[count.index]["cidr_block"]
  map_public_ip_on_launch = false
  tags = {
    Name = var.my_private_subnet[count.index]["tag_name"]
  }
}
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    "Name" = "My_IGW"
  }
}
resource "aws_eip" "my_eip" {
  vpc = true
  depends_on = [
    aws_internet_gateway.my_igw
  ]
  tags = {
    "Name" = "My_EIP"
  }
}
resource "aws_nat_gateway" "my_nat" {
  subnet_id     = aws_subnet.my_public_subnet[0].id
  allocation_id = aws_eip.my_eip.id
  tags = {
    "Name" = "My_NAT"
  }
}
resource "aws_route_table" "my_public_route" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block = var.my_route_cidr_block
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    "Name" = "My_Public_Route"
  }
}
resource "aws_route_table" "my_private_table" {
  vpc_id = aws_vpc.my_vpc.id
  route {
    cidr_block     = var.my_route_cidr_block
    nat_gateway_id = aws_nat_gateway.my_nat.id
  }
  tags = {
    "Name" = "My_Private_Route"
  }
}
resource "aws_route_table_association" "my_public_route_association" {
  count          = length(var.my_public_subnet)
  route_table_id = aws_route_table.my_public_route.id
  subnet_id      = aws_subnet.my_public_subnet[count.index].id
}
resource "aws_route_table_association" "my_private_route_association" {
  count          = length(var.my_private_subnet)
  route_table_id = aws_route_table.my_private_table.id
  subnet_id      = aws_subnet.my_private_subnet[count.index].id
}