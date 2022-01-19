resource "aws_ecs_task_definition" "app" {
  family                   = "${var.main_project}-${var.sub_project}-taskdef"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  container_definitions    = file("modules/ecs-taskdef/taskdef.json")
  execution_role_arn       = var.ecs_task_execution_role_arn
  task_role_arn            = var.task_role_arn

  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  volume {
    name = "graphite"

    efs_volume_configuration {
      file_system_id     = var.efs_file_system_id
      transit_encryption = "ENABLED"
      authorization_config {
        access_point_id = var.efs_access_point_id
      }
    }
  }

  tags = {
    Project = var.main_project
  }
}
