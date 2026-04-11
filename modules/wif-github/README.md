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
| [google_iam_workload_identity_pool.pool](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool) | resource |
| [google_iam_workload_identity_pool_provider.provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/iam_workload_identity_pool_provider) | resource |
| [google_project_iam_member.sa_roles](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_iam_member) | resource |
| [google_project_service.iamcredentials](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/project_service) | resource |
| [google_service_account.deploy](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account) | resource |
| [google_service_account_iam_member.wif_binding](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/service_account_iam_member) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_org"></a> [github\_org](#input\_github\_org) | GitHub organisation or username that is allowed to authenticate. | `string` | n/a | yes |
| <a name="input_pool_id"></a> [pool\_id](#input\_pool\_id) | Workload Identity Pool ID. | `string` | `"github"` | no |
| <a name="input_project_id"></a> [project\_id](#input\_project\_id) | Project ID where the WIF pool and SA will be created. | `string` | n/a | yes |
| <a name="input_provider_id"></a> [provider\_id](#input\_provider\_id) | Workload Identity Provider ID. | `string` | `"foundation"` | no |
| <a name="input_repositories"></a> [repositories](#input\_repositories) | List of GitHub repositories allowed to authenticate (format: owner/repo). | `list(string)` | n/a | yes |
| <a name="input_sa_id"></a> [sa\_id](#input\_sa\_id) | Service account ID to create for GitHub Actions. | `string` | `"sa-ops-github-deploy"` | no |
| <a name="input_sa_project_roles"></a> [sa\_project\_roles](#input\_sa\_project\_roles) | IAM roles to grant the SA on the project. | `list(string)` | <pre>[<br/>  "roles/billing.projectManager",<br/>  "roles/iam.serviceAccountAdmin",<br/>  "roles/iam.workloadIdentityPoolAdmin",<br/>  "roles/resourcemanager.projectIamAdmin",<br/>  "roles/serviceusage.serviceUsageAdmin",<br/>  "roles/storage.admin"<br/>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_provider_name"></a> [provider\_name](#output\_provider\_name) | Full provider resource name. Use as GCP\_WORKLOAD\_IDENTITY\_PROVIDER in GitHub secrets. |
| <a name="output_sa_email"></a> [sa\_email](#output\_sa\_email) | Service account email. Use as GCP\_SERVICE\_ACCOUNT in GitHub secrets. |
