# Naming Conventions

Our naming follows patterns from
[Google cloud-foundation-fabric](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric),
[Azure Cloud Adoption Framework](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming),
and general industry consensus. We didn't reinvent the wheel — we just picked a prefix.

## Prefix

All resources use the prefix `ops`. GCP project IDs are globally unique, so some
resources have a random suffix (e.g., `ops-admin-7x2`). This is normal and expected.

## Pattern

```
{prefix}-{env}-{purpose}
```

Where:
- **prefix** = `ops` (our org identifier)
- **env** = `dev`, `stg`, `prd` (omitted for shared/admin resources)
- **purpose** = what the resource does

## Resource Names

### Bootstrap (created manually, not managed by Terraform)

| Resource | Name | Notes |
|----------|------|-------|
| Admin project | `ops-admin-7x2` | Holds state bucket and Terraform SA |
| State bucket | `ops-tfstate-7x2` | Single bucket, all environments |

### Per Environment (created by Terraform)

| Resource | Pattern | Dev example |
|----------|---------|-------------|
| Project | `ops-{env}-7x2` | `ops-dev-7x2` |
| Service account | `sa-ops-{env}-{purpose}` | `sa-ops-dev-deploy` |
| GCS bucket | `ops-{env}-{purpose}-7x2` | `ops-dev-data-7x2` |

### Why the `7x2` suffix?

GCP project IDs and bucket names must be globally unique across all of Google
Cloud. `ops-admin` was already taken by someone else. We appended `7x2` to make
it unique. This is the same approach Google recommends in their
[enterprise foundations blueprint](https://cloud.google.com/architecture/landing-zones/decide-resource-hierarchy).

## Labels

Every resource gets these labels:

| Key | Value | Example |
|-----|-------|---------|
| `environment` | `dev`, `stg`, `prd` | `dev` |
| `managed_by` | `terraform` | `terraform` |
| `team` | team name | `platform` |

## Service Account Naming

Service accounts use the `sa-` prefix so they're immediately identifiable:

```
sa-{prefix}-{env}-{purpose}

sa-ops-dev-deploy      # deployment automation
sa-ops-prd-monitoring  # monitoring agent
```
