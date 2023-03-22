provider "aws" {
  region = "us-east-2"
  alias  = "identity"
  assume_role {
    role_arn     = "arn:aws:iam::500007662536:role/IACAccountAdmin"
    session_name = "Terraform"
  }
}

provider "aws" {
  region = "us-east-2"
  alias  = "tools"
  assume_role {
    role_arn     = "arn:aws:iam::542877350747:role/IACAccountAdmin"
    session_name = "Terraform"
  }
}

provider "aws" {
  region = "us-east-2"
  alias  = "audit"
  assume_role {
    role_arn     = "arn:aws:iam::885627971796:role/IACAccountAdmin"
    session_name = "Terraform"
  }
}

provider "aws" {
  region = "us-east-2"
  alias  = "prod-use2"
  assume_role {
    role_arn     = "arn:aws:iam::991637987191:role/IACAccountAdmin"
    session_name = "Terraform"
  }
}

provider "aws" {
  region = "us-east-2"
  alias  = "prod-usw2"
  assume_role {
    role_arn     = "arn:aws:iam::991637987191:role/IACAccountAdmin"
    session_name = "Terraform"
  }
}

provider "aws" {
  region = "us-east-2"
  alias  = "non-prod"
  assume_role {
    role_arn     = "arn:aws:iam::394226459056:role/IACAccountAdmin"
    session_name = "Terraform"
  }
}
