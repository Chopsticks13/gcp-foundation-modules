# Organization Configuration (No Org/Folder Structure)

locals {
  # No organization - using individual account
  organization_id = null
  
  billing_account = "018634-AC68FD-0FE666"
  
  terraform_state_project = "seventh-chassis-480823-p0"
  terraform_state_bucket  = "seventh-chassis-tfstate"
  
  default_region = "europe-west2"
  domain = "personal"
}