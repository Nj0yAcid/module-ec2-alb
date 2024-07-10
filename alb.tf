resource "aws_lb_target_group" "alb_target_group" {
  name     = "tf-example-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my_vpc.id

    health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 10
    matcher             = 200
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 6
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group_attachment" "name" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  target_id = aws_instance.webserver.id
  port = 80
}

resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.application-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

resource "aws_lb" "application-lb" {
  name               = "application-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  enable_deletion_protection = false



  tags = {
    Environment = "production"
  }
}