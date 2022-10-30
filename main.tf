module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_details.name
  cidr = var.vpc_details.cidr

  azs             = [format("%sa", local.region), format("%sb", local.region)]
  private_subnets = ["192.168.0.0/24", "192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
  public_subnets  = ["192.168.4.0/24", "192.168.5.0/24"]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}