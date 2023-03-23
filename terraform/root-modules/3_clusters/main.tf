## Environment CIDRS
# Tools:      10.0.0.0/12
# Production: 10.16.0.0/12
# Staging:    10.32.0.0/12
# Sandbox:    10.48.0.0/12

module "tools_1_cluster" {
  source = "./modules/eks_cluster"
  providers = {
    aws = aws.tools
  }
  name = "main"
  env  = "tools"
  cidr = "10.0.0.0/16"
}

module "prod_1_cluster" {
  source = "./modules/eks_cluster"
  providers = {
    aws = aws.prod-use2
  }
  name = "main"
  env  = "production"
  cidr = "10.16.0.0/16"
}

module "prod_2_cluster" {
  source = "./modules/eks_cluster"
  providers = {
    aws = aws.prod-usw2
  }
  name = "main"
  env  = "production"
  cidr = "10.18.0.0/16"
}

module "staging_1_cluster" {
  source = "./modules/eks_cluster"
  providers = {
    aws = aws.non-prod
  }
  name            = "main"
  cidr            = "10.32.0.0/16"
  env             = "staging"
  cluster_version = "1.26"
}

