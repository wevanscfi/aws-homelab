data "terraform_remote_state" "networking" {
  backend = "s3"

  config = {
    bucket         = "tf-remote-state20230301033314201300000002"
    encrypt        = true
    kms_key_id     = "c857aeb8-99fe-428f-992d-9f56b215e5f9"
    dynamodb_table = "tf-remote-state-lock"
    key            = "networking/terraform.tfstate"
    region         = "us-east-2"
  }
}

module "tools_east_cluster" {
  source = "./modules/eks_cluster"
  providers = {
    aws = aws.tools
  }
  name = "main"
  env  = "tools"
}

module "prod_east_cluster" {
  source = "./modules/eks_cluster"
  providers = {
    aws = aws.prod-use2
  }
  name = "main"
  env  = "production"
}

module "prod_west_cluster" {
  source = "./modules/eks_cluster"
  providers = {
    aws = aws.prod-usw2
  }
  name = "main"
  env  = "production"
}

module "staging_east_cluster" {
  source = "./modules/eks_cluster"
  providers = {
    aws = aws.non-prod
  }
  name = "main"
  env  = "staging"
}

