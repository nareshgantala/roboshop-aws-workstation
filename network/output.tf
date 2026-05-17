output "subnet_id" {
  value = aws_subnet.workstation_subnet.id
}

output "sg_id" {
  value = aws_security_group.allow_all.id
}