## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9 |
| <a name="requirement_google"></a> [google](#requirement\_google) | >= 6.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 7.27.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_project_iam_member.project_roles](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_service_account.sa](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_binding.authoritative](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_binding) | resource |
| [google_service_account_iam_member.additive](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_description"></a> [description](#input\_description) | Service account description. | `string` | `"Managed by Terraform."` | no |
| <a name="input_display_name"></a> [display\_name](#input\_display\_name) | Display name for the service account. | `string` | `null` | no |
| <a name="input_iam"></a> [iam](#input\_iam) | Authoritative IAM bindings ON this service account (who can impersonate it). Keys are roles, values are lists of members. | `map(list(string))` | `{}` | no |
| <a name="input_iam_additive"></a> [iam\_additive](#input\_iam\_additive) | Non-authoritative IAM bindings ON this service account. | `map(list(string))` | `{}` | no |
| <a name="input_iam_project_roles"></a> [iam\_project\_roles](#input\_iam\_project\_roles) | Project-level IAM roles granted TO this service account. Keys are project IDs, values are lists of roles. | `map(list(string))` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Service account ID (the part before @). | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID where the service account will be created. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_email"></a> [email](#output\_email) | Service account email. |
| <a name="output_id"></a> [id](#output\_id) | Fully qualified service account ID. |
| <a name="output_member"></a> [member](#output\_member) | IAM member string (serviceAccount:email). |
| <a name="output_name"></a> [name](#output\_name) | Service account resource name. |
