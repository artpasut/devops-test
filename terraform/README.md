# Terraform

## About

Terrform is a powerful tool for building infrastrucutre with concepts of IaC.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | latest |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_app_ecs_service"></a> app\_ecs\_service | ./modules/ecs-service | 1.0.0 |
| <a name="module_ecr"></a> ecr | ./modules/ecr | 1.0.0 |
| <a name="module_ecs_cluster"></a> ecs\_cluster | ./modules/ecs-cluster | 1.0.0 |
| <a name="module_efs"></a> efs| ./modules/efs | 1.0.0 |
| <a name="module_task_definition"></a> task\_definition | ./modules/ecs-taskdef | 1.0.0 |
| <a name="module_vpc"></a> vpc | ./modules/vpc | 1.0.0 |

## Infrastructure Design

![Diagram](../images/architecture-diagram.png?raw=true "Diagram")

## Usage
Firstly, modify aws profile and parameters in each imported modules in main.tf.
```bash
#initialize terraform.
terraform init
#planing what resources will be create by terraform.
terraform plan
#deploy resouces according to plan.
terraform apply
```