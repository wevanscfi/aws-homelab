data "aws_ssoadmin_instances" "this" {}

resource "aws_ssoadmin_permission_set" "developer" {
  name         = "Example"
  instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]
}

data "aws_iam_policy_document" "developer_s3" {
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

    condition {
      test     = "ForAnyValue:StringEquals"
      variable = "s3:ExistingObjectTag/DataClassification"

      values = [
        "sensative",
        "confidential",
      ]
    }

    condition {
      test     = "ForAnyValue:StringNotEquals"
      variable = "s3:ExistingObjectTag/DataClassification"

      values = [
        "pii",
        "phi",
        "customer-confidential",
      ]
    }
  }
}

resource "aws_ssoadmin_permission_set_inline_policy" "developer" {
  inline_policy      = data.aws_iam_policy_document.developer_s3.json
  instance_arn       = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.developer.arn
}

