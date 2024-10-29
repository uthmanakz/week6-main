resource "aws_security_group" "sg_lb"{
    vpc_id = var.vpc 
    name = var.sg_lb_name
    egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

ingress {
    from_port = var.port
    to_port = var.port
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_lb" "lb_frontend" {
  name               = "LB-FRONTEND"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg_lb.id]
  subnets            = [var.pub_sub1, var.pub_sub2]
}


resource "aws_lb_target_group" "tg_lb" {
  name     = "TG-LB-FRONTEND"
  port     = var.port
  protocol = "HTTP"
  vpc_id   = var.vpc
  
  health_check {
    path                = "/"
}

}

resource "aws_lb_listener" "lb_listener_frontend" {
  load_balancer_arn = aws_lb.lb_frontend.arn
  port              = var.port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg_lb.arn
  }
}


resource "aws_lb_target_group_attachment" "tg_attatchment_frontend1" {
  target_group_arn = aws_lb_target_group.tg_lb.arn
  target_id        = var.target1 
  port             = 80
}

resource "aws_lb_target_group_attachment" "tg_attatchment_frontend2" {
  target_group_arn = aws_lb_target_group.tg_lb.arn
  target_id        = var.target2 
  port             = 80
}