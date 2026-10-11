terraform {
  source = "${get_repo_root()}/modules//vpc"
}

include "root" {
  path   = find_in_parent_folders("root.hcl")
  expose = true
}

include "org" {
  path   = find_in_parent_folders("org.hcl")
  expose = true
}

inputs = {
  project_id = dependency.project.outputs.project_id
  name       = values.network_name

  subnets = [
    {
      name          = values.subnet_name
      region        = include.org.locals.default_region
      ip_cidr_range = values.subnet_cidr
    }
  ]

  nat = {
    region = include.org.locals.default_region
  }
}
