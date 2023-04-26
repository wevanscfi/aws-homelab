locals {
  cidrs = {
    tools     = "10.0.0.0/12"
    prod_east = "10.16.0.0/12"
    prod_west = "10.32.0.0/12"
    staging   = "10.48.0.0/12"
    sandbox   = "10.64.0.0/12"
  }
}

module "tools" {
  source = "./modules/vpc"
  providers = {
    aws = aws.tools
  }
  env = "tools"
  networks = {
    main = cidrsubnet(local.cidrs.tools, 4, 0)
  }
}

module "prod_east" {
  source = "./modules/vpc"
  providers = {
    aws = aws.prod-use2
  }
  env = "production"
  networks = {
    main = cidrsubnet(local.cidrs.prod_east, 4, 0)
    bi   = cidrsubnet(local.cidrs.prod_east, 4, 1)
  }
}

module "prod_west" {
  source = "./modules/vpc"
  providers = {
    aws = aws.prod-usw2
  }
  env = "production"
  networks = {
    main = cidrsubnet(local.cidrs.prod_west, 4, 0)
    bi   = cidrsubnet(local.cidrs.prod_west, 4, 1)
  }
}

module "staging" {
  source = "./modules/vpc"
  providers = {
    aws = aws.non-prod
  }
  env = "staging"
  networks = {
    main = cidrsubnet(local.cidrs.staging, 4, 0)
  }
}

module "sandbox" {
  source = "./modules/vpc"
  providers = {
    aws = aws.sandbox
  }
  env = "sandbox"
  networks = {
    main = cidrsubnet(local.cidrs.sandbox, 4, 0)
  }
}

