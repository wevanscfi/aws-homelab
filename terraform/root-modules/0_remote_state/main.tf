provider "aws" {
  region = "us-east-2"
}

provider "aws" {
  alias  = "replica"
  region = "us-west-1"
}

module "remote_state" {
  source = "nozaq/remote-state-s3-backend/aws"

  providers = {
    aws         = aws
    aws.replica = aws.replica
  }
}

output "remote_state_bucket" {
  value = module.remote_state.state_bucket.bucket
}

output "remote_lock_table" {
  value = module.remote_state.dynamodb_table.name
}

output "remote_kms_key" {
  value = module.remote_state.kms_key.id
}

