locals {
  account_prefix = "wevanshomelab"
  email_domain   = "wevans.io"
  accounts = {
    core = [
      "identity",
      "tools",
      "audit"
    ],
    platform = [
      "prod",
      "non-prod"
    ],
  }
}

resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
  aws_service_access_principals = [
    "sso.amazonaws.com",
  ]
}

module "org_units" {
  for_each = local.accounts
  source   = "./modules/organizational_unit"
  name     = each.key
  org_id   = aws_organizations_organization.org.roots[0].id
  accounts = each.value
}

output "core_accounts" {
  value = module.org_units["core"].accounts
}

output "platform_accounts" {
  value = module.org_units["platform"].accounts
}

