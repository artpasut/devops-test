resource "aws_ecs_service" "ecs" {
  name                    = "${var.main_project}-${var.sub_project}-service-${var.environment}"
  cluster                 = var.ecs_cluster_arn
  task_definition         = var.task_definition_arn
  launch_type             = "FARGATE"
  enable_ecs_managed_tags = "true"
  propagate_tags          = "TASK_DEFINITION"
  desired_count           = 1

  network_configuration {
    security_groups  = var.ecs_task_security_group_id
    subnets          = var.app_subnets_id
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_alb_target_group.ecs_service.arn
    container_name   = var.graphite_container_name
    container_port   = var.graphite_web_port
  }

  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }

  tags = {
    Project     = var.main_project
    Environment = var.environment
  }
}

resource "aws_alb_target_group" "ecs_service" {
  name        = "${var.main_project}-${var.sub_project}-tg-${var.environment}"
  port        = var.graphite_web_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200-399"
    timeout             = "3"
    path                = var.container_health_check_path
    unhealthy_threshold = "2"
  }
  tags = {
    Project     = var.main_project
    Environment = var.environment
  }
}
