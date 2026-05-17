module "network" {
  source = "./network"
  vpc_id = var.vpc_id
}

module "ec2" {
  for_each = var.instance_name
  source = "./ec2"
  subnet_id = module.network.subnet_id
  instance_name = each.key
  instance_type = each.value
  sg_id = module.network.sg_id
}