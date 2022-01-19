output "alb_dns_name" {
  value = aws_alb.alb.dns_name
}

output "task_role_arn" {
  value = aws_iam_role.ecs_task_role.arn
}

output "task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution_role.arn
}

output "ecs_tasks_security_group_id" {
  value = aws_security_group.ecs_tasks.id
}

output "ecs_cluster_arn" {
  value = aws_ecs_cluster.ecs.arn
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.ecs.name
}

output "ecs_cluster_vpc_id" {
  value = aws_security_group.ecs_tasks.vpc_id
}
