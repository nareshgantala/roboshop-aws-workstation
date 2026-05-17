module "network" {
  source = "./network"
  vpc_id = var.vpc_id
}

module "iam" {
  source = "./iam"
}

module "ec2" {
  for_each = var.instance_name
  source = "./ec2"
  subnet_id = module.network.subnet_id
  instance_name = each.key
  instance_type = each.value
  sg_id = module.network.sg_id
  profile = module.iam.profile
}

resource "null_resource" "file" {
    depends_on = [ module.ec2["workstation"].pip ]
  provisioner "file" {
  source = "./install.sh"
  destination = "/home/ec2-user/install.sh"
    connection {
        type     = "ssh"
        user        = "ec2-user"
        private_key = file("C:\\Users\\DELL\\Downloads\\roboshop_pem.pem")
        host     = module.ec2["workstation"].pip
  }
}

}

resource "null_resource" "name" {
    depends_on = [ null_resource.file ]
  provisioner "remote-exec" {
        connection {
        type     = "ssh"
        user        = "ec2-user"
        private_key = file("C:\\Users\\DELL\\Downloads\\roboshop_pem.pem")
        host     = module.ec2["workstation"].pip
  }

    inline = [ 
        "chmod +x /home/ec2-user/install.sh",
        "bash /home/ec2-user/install.sh"
     ]
  }
}