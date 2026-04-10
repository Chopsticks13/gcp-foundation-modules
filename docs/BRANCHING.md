# Branching & Deployment Strategy

## Trunk-Based Development

`main` is the single source of truth. All changes go through short-lived branches.

```mermaid
gitGraph
  commit id: "v0.1.0"
  branch feat/vpc-module
  commit id: "add vpc module"
  commit id: "add tests"
  checkout main
  merge feat/vpc-module id: "squash merge"
  branch fix/label-case
  commit id: "lowercase labels"
  checkout main
  merge fix/label-case id: "squash merge " type: HIGHLIGHT
  commit id: "v0.2.0" tag: "v0.2.0"
```

## Branch Naming

```
{type}/{description}
```

| Prefix | Use | Example |
|--------|-----|---------|
| `feat/` | New module, resource, capability | `feat/add-vpc-module` |
| `fix/` | Bug fix, config correction | `fix/project-labels-lowercase` |
| `chore/` | Maintenance, dependencies, tooling | `chore/upgrade-tg-1.0` |
| `docs/` | Documentation only | `docs/readme-overhaul` |
| `refactor/` | Restructuring, no behaviour change | `refactor/extract-sa-module` |

## How a Change Flows

```mermaid
flowchart LR
  A[Create branch] --> B[Push commits]
  B --> C[Open PR]
  C --> D{CI passes?}
  D -->|No| B
  D -->|Yes| E[Review + Approve]
  E --> F[Squash merge to main]
  F --> G[Branch auto-deleted]
  F --> H{Deploy}
  H --> I[dev: auto-apply]
  H --> J[staging: manual gate]
  H --> K[prod: manual + reviewer]
```

## Branch Protection on main

```mermaid
flowchart TD
  PR[Pull Request to main] --> checks{Status checks}
  checks -->|validate| fmt[terraform fmt]
  checks -->|validate| val[terraform validate]
  checks -->|validate| lint[tflint]
  checks -->|security| sec[checkov + trufflehog]
  checks -->|plan| plan[terragrunt plan]
  fmt & val & lint & sec & plan --> gate{All pass?}
  gate -->|Yes| review[Review required]
  gate -->|No| blocked[Merge blocked]
  review --> merge[Squash merge]
  merge --> linear[Linear history enforced]
```

## Rules

1. **main** is always deployable
2. Branches live max 1-2 days
3. Squash merge only (linear history)
4. Environments are Terragrunt stacks, not git branches
5. No force pushes to main

## Releases

Tag main with semver, GitHub Actions creates the release automatically.

```bash
git tag -a v0.1.0 -m "Day 1 module kit"
git push origin v0.1.0
```

Consumers pin to tags:

```hcl
terraform {
  source = "git::https://github.com/Chopsticks13/gcp-foundation-modules.git//modules/project?ref=v0.1.0"
}
```
