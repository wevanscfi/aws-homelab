output "aws_resource" {
  value = {
    Terraform          = "true"
    Environment        = var.env
    Criticality        = var.criticality
    Owner              = var.owner
    DataClassification = var.data_classification
  }
}

