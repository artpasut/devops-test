resource "aws_ecs_cluster" "ecs" {
  name = "${var.main_project}-ecs-cluster-${var.environment}"
  setting {
    name  = "containerInsights"
    value = "enabled"
  }
  tags = {
    Project     = var.main_project
    Environment = var.environment
  }
}

resource "aws_security_group" "ecs_tasks" {
  name        = "${var.main_project}-app-sg-${var.environment}"
  description = "${var.main_project} application security group"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = var.graphite_web_port
    to_port         = var.graphite_web_port
    security_groups = [aws_security_group.alb.id]
  }

  ingress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name        = "${var.main_project}-app-sg-${var.environment}"
    Project     = var.main_project
    Environment = var.environment
  }
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${var.main_project}-ecs-task-role"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
  tags = {
    Project     = var.main_project
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.main_project}-ecs-task-execution-role"

  assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
       "Service": "ecs-tasks.amazonaws.com"
     },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
  tags = {
    Project     = var.main_project
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}
