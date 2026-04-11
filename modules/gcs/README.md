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
| [google_storage_bucket.bucket](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_binding.authoritative](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/storage_bucket_iam_binding) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_encryption_key"></a> [encryption\_key](#input\_encryption\_key) | CMEK key self-link for bucket encryption. Null uses Google-managed encryption. | `string` | `null` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | Allow bucket deletion even if it contains objects. | `bool` | `false` | no |
| <a name="input_iam"></a> [iam](#input\_iam) | Authoritative IAM bindings. Keys are roles, values are lists of members. | `map(list(string))` | `{}` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Resource labels. | `map(string)` | `{}` | no |
| <a name="input_lifecycle_rules"></a> [lifecycle\_rules](#input\_lifecycle\_rules) | Bucket lifecycle rules. | <pre>list(object({<br/>    action = object({<br/>      type          = string<br/>      storage_class = optional(string)<br/>    })<br/>    condition = object({<br/>      age                   = optional(number)<br/>      created_before        = optional(string)<br/>      num_newer_versions    = optional(number)<br/>      matches_storage_class = optional(list(string))<br/>      with_state            = optional(string)<br/>    })<br/>  }))</pre> | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | Bucket location. | `string` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | Bucket name. Must be globally unique. | `string` | n/a | yes |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID. | `string` | n/a | yes |
| <a name="input_retention_policy"></a> [retention\_policy](#input\_retention\_policy) | Retention policy. Null disables retention. | <pre>object({<br/>    retention_period = number<br/>    is_locked        = optional(bool, false)<br/>  })</pre> | `null` | no |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | Bucket storage class. | `string` | `"STANDARD"` | no |
| <a name="input_versioning"></a> [versioning](#input\_versioning) | Enable object versioning. | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | Bucket resource ID. |
| <a name="output_name"></a> [name](#output\_name) | Bucket name. |
| <a name="output_self_link"></a> [self\_link](#output\_self\_link) | Bucket self link. |
| <a name="output_url"></a> [url](#output\_url) | Bucket URL (gs://BUCKET\_NAME). |
