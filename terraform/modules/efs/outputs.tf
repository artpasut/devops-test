output "efs_id" {
  value = aws_efs_file_system.storage.id
}

output "efs_access_point_id" {
  value = aws_efs_access_point.storage.id
}
