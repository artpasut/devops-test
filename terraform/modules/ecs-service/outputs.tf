output "ecs_service_name" {
  value = aws_ecs_service.ecs.name
}

output "ecs_container_name" {
  value = aws_ecs_service.ecs.load_balancer.*.container_name
}

output "ecs_service_target_group_arn" {
  value = aws_alb_target_group.ecs_service.arn
}
