# GCP Foundation Modules

Reusable Terraform modules + Terragrunt compositions for GCP infrastructure.
Follows [cloud-foundation-fabric](https://github.com/GoogleCloudPlatform/cloud-foundation-fabric) design patterns.

## Getting Started

### Prerequisites

Install [mise](https://mise.jdx.dev):

```bash
curl https://mise.jdx.dev/install.sh | sh
```

### Setup

```bash
git clone https://github.com/Chopsticks13/gcp-foundation-modules.git
cd gcp-foundation-modules
mise trust    # trust this repo's mise.toml
mise install  # installs all tools at pinned versions
pre-commit install  # set up git hooks
```

## Repository Structure

```
gcp-foundation-modules/
├── modules/          # Pure Terraform modules
├── units/            # Terragrunt unit definitions (reusable)
├── stacks/           # Reusable stack blueprints
├── live/             # Actual deployments (dev/staging/prod)
├── data/             # Factory data (YAML-driven resources)
├── root.hcl          # Remote state + provider generation
├── org.hcl           # Org-wide config (billing, region)
└── mise.toml         # Tool version pinning
```

## Branching Strategy

Trunk-based development. See [docs/BRANCHING.md](docs/BRANCHING.md) for details.

- `main` is the single source of truth
- Short-lived feature branches: `feat/`, `fix/`, `chore/`, `docs/`, `refactor/`
- Squash merge to main, delete the branch

## Releases

Semantic versioning with git tags. Pin module consumers to a tag:

```hcl
terraform {
  source = "git::https://github.com/Chopsticks13/gcp-foundation-modules.git//modules/project?ref=v0.1.0"
}
```

## Tool Versions

All tool versions are pinned in [mise.toml](mise.toml). Run `mise install` to get the exact versions used by CI.
