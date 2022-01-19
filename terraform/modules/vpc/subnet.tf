#Subnet
#App subnet
resource "aws_subnet" "pub_subnet" {
  count                   = length(var.az)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 3, count.index)
  availability_zone       = element(var.az, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.main_project}-pub-${element(var.az_name, count.index)}"
  }
}

#App subnet
resource "aws_subnet" "app_subnet" {
  count                   = length(var.az)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 3, count.index + 3)
  availability_zone       = element(var.az, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.main_project}-app-${element(var.az_name, count.index)}"
  }
}
#Secure subnet
resource "aws_subnet" "secure_subnet" {
  count                   = length(var.az)
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, count.index + 12)
  availability_zone       = element(var.az, count.index)
  map_public_ip_on_launch = false
  tags = {
    Name = "${var.main_project}-secure-${element(var.az_name, count.index)}"
  }
}
