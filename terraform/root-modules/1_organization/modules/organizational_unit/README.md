## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_organizations_account.core](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account) | resource |
| [aws_organizations_organizational_unit.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_organizational_unit) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_accounts"></a> [accounts](#input\_accounts) | A list of accounts to create within the organizational unit | `list(string)` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | The name of the organizational unit | `string` | n/a | yes |
| <a name="input_org_id"></a> [org\_id](#input\_org\_id) | The top level organization id | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_accounts"></a> [accounts](#output\_accounts) | n/a |
| <a name="output_org_units"></a> [org\_units](#output\_org\_units) | n/a |
