#Prefix
variable "main_project" {
  description = "Prefix"
}

#VPC CIDR
variable "vpc_cidr" {
  description = "prduction VPC Cidr Block"
}

variable "az" {
  description = "avalability zone for this account"
  type        = list(any)
}

variable "az_name" {
  description = "avalability zone name for this account"
  type        = list(any)
}
