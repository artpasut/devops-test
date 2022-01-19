resource "aws_alb" "alb" {
  name            = "${var.main_project}-alb-${var.environment}"
  subnets         = var.alb_subnets_id
  security_groups = [aws_security_group.alb.id]
  tags = {
    Project     = var.main_project
    Environment = var.environment
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = var.target_group_arn
  }
}

resource "aws_security_group" "alb" {
  name        = "${var.main_project}-alb-sg-${var.environment}"
  description = "${var.main_project} application load balancer security group"
  vpc_id      = var.vpc_id

  ingress {
    protocol    = "tcp"
    from_port   = "80"
    to_port     = "80"
    cidr_blocks = var.alb_security_group_cidr_inbound
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "${var.main_project}-alb-sg-${var.environment}"
    Project     = var.main_project
    Environment = var.environment
  }
}


