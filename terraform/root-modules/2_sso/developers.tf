resource "aws_identitystore_group" "developers" {
  display_name      = "Developers"
  description       = "The SSO group for all software engineers on service teams"
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
}

resource "aws_ssoadmin_permission_set" "developers" {
  name         = "Example"
  instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]
}

resource "aws_ssoadmin_account_assignment" "developers" {
  for_each           = data.terraform_remote_state.org.outputs.platform_accounts
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.developers.arn

  principal_id   = aws_identitystore_group.developers.group_id
  principal_type = "GROUP"

  target_id   = each.value.id
  target_type = "AWS_ACCOUNT"
}

data "aws_iam_policy_document" "developers_s3" {
  statement {
    actions = [
      "s3:List*",
      "s3:Get*",
      "s3:PutObject",
      "s3:PutObjectAcl",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

resource "aws_ssoadmin_permission_set_inline_policy" "developers" {
  inline_policy      = data.aws_iam_policy_document.developers_s3.json
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.developers.arn
}

resource "aws_ssoadmin_managed_policy_attachment" "developers-ec2" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  managed_policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.platforms.arn
}

