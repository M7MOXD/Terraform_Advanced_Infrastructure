resource "aws_instance" "my_public_ec2" {
  count                       = length(var.my_public_ec2)
  ami                         = var.my_ami_id
  instance_type               = var.my_public_ec2[count.index]["instance_type"]
  subnet_id                   = var.my_public_subnet_ids[count.index]
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.my_public_ec2_sg_id]
  key_name                    = var.my_key_name
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y ",
      "echo 'server {\nlisten 80 default_server;\nlisten [::]:80 default_server;\nserver_name _;\nlocation / {\nproxy_pass http://${var.my_private_lb_dns};\n}\n}' > default",
      "sudo mv default /etc/nginx/sites-enabled/default",
      "sudo systemctl restart nginx"
    ]
  }
  connection {
    host        = self.public_ip
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("my_key.pem")
  }
  provisioner "local-exec" {
    command = "echo Public_IP: ${self.public_ip} >> IPs.txt"
  }
  tags = {
    "Name" = var.my_public_ec2[count.index]["tag_name"]
  }
}
resource "aws_instance" "my_private_ec2" {
  count                       = length(var.my_private_ec2)
  ami                         = var.my_ami_id
  instance_type               = var.my_private_ec2[count.index]["instance_type"]
  subnet_id                   = var.my_private_subnet_ids[count.index]
  associate_public_ip_address = false
  vpc_security_group_ids      = [var.my_private_ec2_sg_id]
  key_name                    = var.my_key_name
  user_data                   = file("user_data.sh")
  tags = {
    "Name" = var.my_private_ec2[count.index]["tag_name"]
  }
  provisioner "local-exec" {
    command = "echo Private_IP: ${self.private_ip} >> IPs.txt"
  }
}
resource "aws_lb_target_group_attachment" "my_public_lb_tg_attachment" {
  count            = length(var.my_public_ec2)
  target_group_arn = var.my_public_lb_tg_arn
  target_id        = aws_instance.my_public_ec2[count.index].id
  port             = 80
}
resource "aws_lb_target_group_attachment" "my_private_lb_tg_attachment" {
  count            = length(var.my_private_ec2)
  target_group_arn = var.my_private_lb_tg_arn
  target_id        = aws_instance.my_private_ec2[count.index].id
  port             = 80
}