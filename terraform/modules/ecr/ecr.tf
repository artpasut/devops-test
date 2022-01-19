resource "aws_ecr_repository" "app" {
  name = "${var.main_project}-${var.sub_project}"

  image_scanning_configuration {
    scan_on_push = true
  }
}
