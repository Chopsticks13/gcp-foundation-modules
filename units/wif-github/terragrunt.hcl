terraform {
  source = "${get_repo_root()}/modules//wif-github"
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
  project_id   = include.org.locals.terraform_state_project
  github_org   = values.github_org
  repositories = values.repositories
}
