resource "aws_instance" "webserver" {
  ami = var.instance-ami
  instance_type = var.instance_type
  key_name = aws_key_pair.keylamp.key_name
  vpc_security_group_ids = [aws_security_group.ec2-sg.id]
  availability_zone = var.subnet_AZ_1
  subnet_id = aws_subnet.private_subnet.id
  user_data = file("/Users/emmanuelvitateka/Desktop/terraform-utrains/module-ec2-vpc/code.sh")
}