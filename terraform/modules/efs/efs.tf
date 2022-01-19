resource "aws_efs_file_system" "storage" {
  encrypted = true
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }

  tags = {
    Name    = "${var.main_project}-graphite-storage"
    Project = var.main_project
  }
}

resource "aws_efs_access_point" "storage" {
  file_system_id = aws_efs_file_system.storage.id

  posix_user {
    gid = 0
    uid = 0
  }

  root_directory {
    path = "/"

    creation_info {
      owner_gid   = 0
      owner_uid   = 0
      permissions = 0755
    }
  }
}

resource "aws_efs_mount_target" "efs-mount-b" {
  file_system_id  = aws_efs_file_system.storage.id
  subnet_id       = var.secure_subnet_b
  security_groups = ["${aws_security_group.efs.id}"]
}

resource "aws_efs_mount_target" "efs-mount-c" {
  file_system_id  = aws_efs_file_system.storage.id
  subnet_id       = var.secure_subnet_c
  security_groups = ["${aws_security_group.efs.id}"]
}

resource "aws_efs_mount_target" "efs-mount-a" {
  file_system_id  = aws_efs_file_system.storage.id
  subnet_id       = var.secure_subnet_a
  security_groups = ["${aws_security_group.efs.id}"]
}


resource "aws_security_group" "efs" {
  name        = "${var.main_project}-efs-sg-${var.environment}"
  description = "${var.main_project} efs security group"
  vpc_id      = var.vpc_id

  ingress {
    protocol        = "tcp"
    from_port       = 2049
    to_port         = 2049
    security_groups = [var.app_security_group]
  }

  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "${var.main_project}-efs-sg-${var.environment}"
    Project = var.main_project
  }
}
