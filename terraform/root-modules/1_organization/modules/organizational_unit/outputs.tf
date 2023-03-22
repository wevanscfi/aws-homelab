output "organizational_unit" {
  value = aws_organizations_organizational_unit.this.id
}

output "accounts" {
  value = aws_organizations_account
}

