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
| [google_compute_shared_vpc_host_project.host](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_shared_vpc_host_project) | resource |
| [google_compute_shared_vpc_service_project.service](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_shared_vpc_service_project) | resource |
| [google_org_policy_policy.policies](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/org_policy_policy) | resource |
| [google_project.project](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project) | resource |
| [google_project_iam_binding.authoritative](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_binding) | resource |
| [google_project_iam_member.additive](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.services](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_billing_account"></a> [billing\_account](#input\_billing\_account) | Billing account ID. | `string` | `null` | no |
| <a name="input_deletion_policy"></a> [deletion\_policy](#input\_deletion\_policy) | Deletion policy for the project. 'PREVENT' protects against accidental deletion. | `string` | `"PREVENT"` | no |
| <a name="input_iam"></a> [iam](#input\_iam) | Authoritative IAM bindings. Keys are roles, values are lists of members. | `map(list(string))` | `{}` | no |
| <a name="input_iam_additive"></a> [iam\_additive](#input\_iam\_additive) | Non-authoritative IAM bindings. Keys are roles, values are lists of members. | `map(list(string))` | `{}` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Resource labels. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | Project display name. | `string` | n/a | yes |
| <a name="input_org_policies"></a> [org\_policies](#input\_org\_policies) | Organisation policy overrides at project level. | <pre>map(object({<br/>    enforce = optional(bool)<br/>    rules = optional(list(object({<br/>      allow = optional(object({<br/>        all    = optional(bool)<br/>        values = optional(list(string))<br/>      }))<br/>      deny = optional(object({<br/>        all    = optional(bool)<br/>        values = optional(list(string))<br/>      }))<br/>      enforce = optional(bool)<br/>      condition = optional(object({<br/>        description = optional(string)<br/>        expression  = string<br/>        title       = string<br/>      }))<br/>    })), [])<br/>  }))</pre> | `{}` | no |
| <a name="input_parent"></a> [parent](#input\_parent) | Parent in 'folders/ID' or 'organizations/ID' format. Null for standalone projects. | `string` | `null` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID. Globally unique, 6-30 characters, lowercase letters, digits, hyphens. | `string` | n/a | yes |
| <a name="input_services"></a> [services](#input\_services) | GCP APIs to enable on the project. | `list(string)` | `[]` | no |
| <a name="input_shared_vpc_host"></a> [shared\_vpc\_host](#input\_shared\_vpc\_host) | Enable this project as a Shared VPC host. | `bool` | `false` | no |
| <a name="input_shared_vpc_service"></a> [shared\_vpc\_service](#input\_shared\_vpc\_service) | Shared VPC host project ID to attach this project to as a service project. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Full project resource ID (projects/PROJECT\_ID). |
| <a name="output_name"></a> [name](#output\_name) | Project display name. |
| <a name="output_number"></a> [number](#output\_number) | Project number. |
| <a name="output_project_id"></a> [project\_id](#output\_project\_id) | Project ID. |
| <a name="output_services"></a> [services](#output\_services) | Enabled services. |
