locals {
  account_prefix = "wevanshomelab"
  email_domain   = "wevans.io"
}

resource "aws_organizations_organizational_unit" "this" {
  name      = var.name
  parent_id = var.org_id
}

resource "aws_organizations_account" "this" {
  for_each  = toset(var.accounts)
  name      = "${local.account_prefix}-${each.key}"
  email     = "admin+aws-${each.key}@${local.email_domain}"
  parent_id = aws_organizations_organizational_unit.this.id
  role_name = "IACAccountAdmin"

  lifecycle {
    ignore_changes = [role_name]
  }
}

