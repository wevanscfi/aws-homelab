resource "aws_identitystore_group" "platforms" {
  display_name      = "Platforms"
  description       = "The SSO group for all platform engineers"
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
}

resource "aws_ssoadmin_permission_set" "platforms" {
  name         = "Example"
  instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]
}

resource "aws_ssoadmin_managed_policy_attachment" "platforms-admin" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  permission_set_arn = aws_ssoadmin_permission_set.platforms.arn
}

resource "aws_ssoadmin_account_assignment" "platforms-core" {
  for_each           = data.terraform_remote_state.org.outputs.core_accounts
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.platforms.arn

  principal_id   = aws_identitystore_group.platforms.group_id
  principal_type = "GROUP"

  target_id   = each.value.id
  target_type = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "platforms-platform" {
  for_each           = data.terraform_remote_state.org.outputs.platform_accounts
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.platforms.arn

  principal_id   = aws_identitystore_group.platforms.group_id
  principal_type = "GROUP"

  target_id   = each.value.id
  target_type = "AWS_ACCOUNT"
}

