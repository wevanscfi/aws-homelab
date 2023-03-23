output "org_units" {
  value = aws_organizations_organizational_unit.this.id
}

output "accounts" {
  value = {
    for k, a in aws_organizations_account.core : k => { name : a.name, id : a.id, arn : a.arn }
  }
}

