# create a security group for the application-lb

resource "aws_security_group" "alb-sg" {
  vpc_id = aws_vpc.my_vpc.id
  description = "security group for the application load balancer"
  name = var.alb_sg_name

  ingress {
    description = "allow httpd"
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    cidr_blocks = [var.alb_sg_ingress_cird_block]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [var.alb_sg_egress_cird_block]
  }
}

# create a security group for the ec2 instance

resource "aws_security_group" "ec2-sg" {
  vpc_id = aws_vpc.my_vpc.id
  description = "security group for the application load balancer"
  name = var.ec2_sg_name

  ingress {
    description = "allow httpd"
    from_port = "80"
    to_port = "80"
    protocol = "tcp"
    security_groups = [aws_security_group.alb-sg.id] 
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [var.ec2_sg_egress_cird_block]
  }
}