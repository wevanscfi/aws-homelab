## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_criticality"></a> [criticality](#input\_criticality) | The business impact this resource has (low, medium, high) | `string` | n/a | yes |
| <a name="input_data_classification"></a> [data\_classification](#input\_data\_classification) | The level of data classification the resource contains, or grants access to (sensisitive, confidential, customer-confidential) | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | The environment this resource is associated with (development, staging, production, tools) | `string` | n/a | yes |
| <a name="input_owner"></a> [owner](#input\_owner) | The team that owns this resource | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_resource"></a> [aws\_resource](#output\_aws\_resource) | n/a |
| <a name="output_name_suffix"></a> [name\_suffix](#output\_name\_suffix) | n/a |
