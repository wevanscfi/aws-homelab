data "aws_availability_zones" "available" {
  state = "available"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.19.0"

  name = "${var.name}-${module.tags.name_suffix}"
  cidr = var.cidr # 10.x.0.0/16

  azs = data.aws_availability_zones.available.names

  private_subnets = [
    cidrsubnet(var.cidr, 4, 0), # 10.x.0.0/20
    cidrsubnet(var.cidr, 4, 1), # 10.x.16.0/20
    cidrsubnet(var.cidr, 4, 2)  # 10.x.32.0/20
  ]

  public_subnets = [
    cidrsubnet(var.cidr, 4, 6), # 10.x.96.0/20
    cidrsubnet(var.cidr, 4, 7), # 10.x.112.0/20
    cidrsubnet(var.cidr, 4, 8)  # 10.x.128.0/20
  ]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = module.tags.aws_resource_tags
}

