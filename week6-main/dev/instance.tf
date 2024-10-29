module "frontend1" {
  source         = "../uthman-module"
  vpc_id         = module.vpc_1.vpc_id
  ingress_port_1 = var.port1
  ingress_port_2 = var.port2
  sg_name        = var.sg_name_dev_1
  node_name      = var.node1
  sub            = module.vpc_1.public_subnets[0]
  ami            = var.ami1
}

module "frontend2" {
  source         = "../uthman-module"
  vpc_id         = module.vpc_1.vpc_id
  ingress_port_1 = var.port1
  ingress_port_2 = var.port2
  sg_name        = var.sg_name_dev_2
  node_name      = var.node2
  sub            = module.vpc_1.public_subnets[1]
  ami            = var.ami1
}


module "backend1" {

  source         = "../uthman-module"
  vpc_id         = module.vpc_1.vpc_id
  ingress_port_1 = var.port1
  ingress_port_2 = var.port3
  sg_name        = var.sg_name_dev_3
  node_name      = var.node3
  sub            = module.vpc_1.private_subnets[0]
  ami            = var.ami2

}

module "backend2" {

  source         = "../uthman-module"
  vpc_id         = module.vpc_1.vpc_id
  ingress_port_1 = var.port1
  ingress_port_2 = var.port3
  sg_name        = var.sg_name_dev_4
  node_name      = var.node4
  sub            = module.vpc_1.private_subnets[1]
  ami            = var.ami2

}





module "lb_public_subnets" {

  source     = "../lb-module"
  port       = var.port2
  vpc        = module.vpc_1.vpc_id
  pub_sub1   = module.vpc_1.public_subnets[0]
  pub_sub2   = module.vpc_1.public_subnets[1]
  target1    = module.frontend1.instance_id
  target2    = module.frontend2.instance_id
  sg_lb_name = var.sg_lb_name1



}


module "redis_cache" {
  source    = "../cache-module"
  priv_sub1 = module.vpc_1.private_subnets[0]
  priv_sub2 = module.vpc_1.private_subnets[1]
}