provider "aws" {
  region  = "ap-southeast-1"
  profile = "dailitech-demo"
  #   shared_credentials_file = "~/.aws/config"
}

terraform {
  backend "s3" {
    bucket  = "art-automation-config"
    key     = "states"
    region  = "ap-southeast-1"
    profile = "dailitech-demo"
  }
}

module "vpc" {
  source       = "./modules/vpc"
  main_project = "example"
  vpc_cidr     = "192.168.0.0/20"
  az           = ["ap-southeast-1b", "ap-southeast-1c", "ap-southeast-1a"]
  az_name      = ["b", "c", "a"]
}

module "ecs_cluster" {
  source                          = "./modules/ecs-cluster"
  main_project                    = "example"
  environment                     = "prod"
  graphite_web_port               = "80"
  target_group_arn                = module.app_ecs_service.ecs_service_target_group_arn
  alb_security_group_cidr_inbound = ["124.120.207.193/32"]
  vpc_id                          = module.vpc.vpc_id
  alb_subnets_id                  = [module.vpc.pub_subnet_b, module.vpc.pub_subnet_c, module.vpc.pub_subnet_a]
}

module "app_ecs_service" {
  source                      = "./modules/ecs-service"
  main_project                = "example"
  sub_project                 = "app"
  environment                 = "prod"
  ecs_cluster_arn             = module.ecs_cluster.ecs_cluster_arn
  task_definition_arn         = module.task_definition.taskdef_arn
  graphite_web_port           = "80"
  graphite_container_name     = "graphite"
  vpc_id                      = module.ecs_cluster.ecs_cluster_vpc_id
  ecs_task_security_group_id  = [module.ecs_cluster.ecs_tasks_security_group_id]
  app_subnets_id              = [module.vpc.app_subnet_b, module.vpc.app_subnet_c, module.vpc.app_subnet_a]
  container_health_check_path = "/"
}

module "task_definition" {
  source                      = "./modules/ecs-taskdef"
  main_project                = "example"
  sub_project                 = "app"
  ecs_task_execution_role_arn = module.ecs_cluster.task_execution_role_arn
  task_role_arn               = module.ecs_cluster.task_role_arn
  efs_file_system_id          = module.efs.efs_id
  efs_access_point_id         = module.efs.efs_access_point_id
}

module "efs" {
  source             = "./modules/efs"
  main_project       = "example"
  environment        = "prod"
  vpc_id             = module.vpc.vpc_id
  app_security_group = module.ecs_cluster.ecs_tasks_security_group_id
  secure_subnet_b    = module.vpc.secure_subnet_b
  secure_subnet_c    = module.vpc.secure_subnet_c
  secure_subnet_a    = module.vpc.secure_subnet_a
}

module "ecr" {
  source       = "./modules/ecr"
  main_project = "example"
  sub_project  = "app"
}
