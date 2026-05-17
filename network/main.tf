resource "aws_subnet" "workstation_subnet" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "workstation_subnet"
  }
}