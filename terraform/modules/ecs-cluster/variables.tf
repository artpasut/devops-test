variable "main_project" {
  description = "main project name"
}

variable "environment" {
  description = "environment name"
}

variable "graphite_web_port" {
  description = "graphite web port"
}

variable "vpc_id" {
  description = "vpc id"
}

variable "alb_subnets_id" {
  description = "list of alb subnets id"
}

variable "target_group_arn" {
  description = "ecs service target group arn"
}

variable "alb_security_group_cidr_inbound" {
  description = "ip cidr for alb security group (inbound)"
}
