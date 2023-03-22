data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = var.name
  cidr = var.cidr

  azs = data.aws_availability_zones.available.names

  private_subnets = [
    cidrsubnet(var.cidr, 4, 0),
    cidrsubnet(var.cidr, 4, 1),
    cidrsubnet(var.cidr, 4, 2)
  ]

  public_subnets = [
    cidrsubnet(var.cidr, 4, 10),
    cidrsubnet(var.cidr, 4, 11),
    cidrsubnet(var.cidr, 4, 12)
  ]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = module.tags.aws_resource
}

