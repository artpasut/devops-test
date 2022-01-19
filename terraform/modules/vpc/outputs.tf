#VPC ID, CIDR
output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "vpc_cidr" {
  value = aws_vpc.vpc.cidr_block
}

output "pub_subnet_b" {
  value = aws_subnet.pub_subnet.0.id
}

output "pub_subnet_c" {
  value = aws_subnet.pub_subnet.1.id
}

output "pub_subnet_a" {
  value = aws_subnet.pub_subnet.2.id
}

output "app_subnet_b" {
  value = aws_subnet.app_subnet.0.id
}

output "app_subnet_c" {
  value = aws_subnet.app_subnet.1.id
}

output "app_subnet_a" {
  value = aws_subnet.app_subnet.2.id
}

output "secure_subnet_b" {
  value = aws_subnet.secure_subnet.0.id
}

output "secure_subnet_c" {
  value = aws_subnet.secure_subnet.1.id
}

output "secure_subnet_a" {
  value = aws_subnet.secure_subnet.2.id
}
