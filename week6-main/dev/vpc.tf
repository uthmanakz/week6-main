 provider "aws" {
  region = "eu-west-2"
}
module "vpc_1" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.cidr_block

  azs             = [var.zone1, var.zone2]
  private_subnets = [var.subnet_cidr_1, var.subnet_cidr_3]
  public_subnets  = [var.subnet_cidr_2, var.subnet_cidr_4]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  map_public_ip_on_launch = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }


}