variable "main_project" {
  description = "main project name"
}

variable "sub_project" {
  description = "sub project name"
}

variable "environment" {
  description = "environment name"
}

variable "ecs_cluster_arn" {
  description = "ecs cluster arn"
}

variable "task_definition_arn" {
  description = "task definition arn"
}

variable "graphite_web_port" {
  description = "graphite web port"
}

variable "vpc_id" {
  description = "vpc id"
}

variable "ecs_task_security_group_id" {
  description = "task security group id"
}

variable "app_subnets_id" {
  description = "list of app subnets id"
}

variable "container_health_check_path" {
  description = "container health check path"
}

variable "graphite_container_name" {
  description = "graphite container name"
}
