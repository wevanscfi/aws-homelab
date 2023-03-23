data "aws_ssoadmin_instances" "this" {}

data "terraform_remote_state" "org" {
  backend = "s3"

  config = {
    bucket         = "tf-remote-state20230301033314201300000002"
    encrypt        = true
    kms_key_id     = "c857aeb8-99fe-428f-992d-9f56b215e5f9"
    dynamodb_table = "tf-remote-state-lock"
    key            = "accounts/terraform.tfstate"
    region         = "us-east-2"
  }
}

