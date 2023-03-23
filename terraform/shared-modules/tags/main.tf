data "aws_region" "current" {}

output "aws_resource" {
  value = {
    Terraform          = "true"
    Environment        = var.env
    Criticality        = var.criticality
    Owner              = var.owner
    Region             = data.aws_region.current.name
    DataClassification = var.data_classification
  }
}

output "name_suffix" {
  value = "${var.env}-${data.aws_region.current.name}"
}

