#NAT Gateway
resource "aws_nat_gateway" "nat_b" {
  allocation_id     = aws_eip.nat_b.id
  subnet_id         = aws_subnet.app_subnet[1].id
  connectivity_type = "public"

  tags = {
    Name    = "${var.main_project}-nat-b"
    Project = var.main_project
  }
}

#Elastic IP
resource "aws_eip" "nat_b" {
  vpc = true
}
