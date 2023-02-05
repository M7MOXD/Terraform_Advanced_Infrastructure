my_vpc = {
  cidr_block : "10.0.0.0/16"
  tag_name : "My_VPC"
}
my_public_subnet = [
  {
    cidr_block : "10.0.0.0/24"
    availability_zone : "us-east-1a"
    tag_name : "My_Public_Subnet_1"
  },
  {
    cidr_block : "10.0.2.0/24"
    availability_zone : "us-east-1b"
    tag_name : "My_Public_Subnet_2"
  }
]
my_private_subnet = [
  {
    cidr_block : "10.0.1.0/24"
    availability_zone : "us-east-1a"
    tag_name : "My_Private_Subnet_1"
  },
  {
    cidr_block : "10.0.3.0/24"
    availability_zone : "us-east-1b"
    tag_name : "My_Private_Subnet_2"
  }
]
my_route_cidr_block = "0.0.0.0/0"
my_public_ec2 = [
  {
    instance_type : "t2.micro"
    tag_name : "My_Public_EC2_1"
  },
  {
    instance_type : "t2.micro"
    tag_name : "My_Public_EC2_2"
  }
]
my_private_ec2 = [
  {
    instance_type : "t2.micro"
    tag_name : "My_Private_EC2_1"
  },
  {
    instance_type : "t2.micro"
    tag_name : "My_Private_EC2_2"
  }
]