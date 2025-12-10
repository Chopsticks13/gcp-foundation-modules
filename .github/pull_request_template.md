## Description

<!-- Provide a clear and concise description of your changes -->

## Type of Change

<!-- Mark the relevant option with an "x" -->

- [ ] New project creation
- [ ] Module enhancement
- [ ] Bug fix
- [ ] CI/CD workflow change
- [ ] Documentation update
- [ ] Refactoring (no functional changes)

## Environments/Projects Affected

<!-- List the environments and projects impacted by this change -->

- **Environment**: <!-- dev/staging/prod/sandbox -->
- **Projects**: <!-- List project IDs -->

## Changes Made

<!-- Provide a bulleted list of changes -->

-
-
-

## Terraform/Terragrunt Plan Output

<!-- Paste the relevant plan output showing what will be created/changed/destroyed -->

<details>
<summary>Plan Output</summary>

```hcl
# Paste your `terragrunt plan` output here
```

</details>

## Testing Performed

<!-- Describe how you tested these changes -->

- [ ] Local `terragrunt plan` executed successfully
- [ ] Local `terragrunt validate` passed
- [ ] `terraform fmt` applied
- [ ] Security scan (tfsec) passed locally
- [ ] Tested in dev environment (if applicable)

## Security Considerations

<!-- Are there any security implications? New IAM roles? Public resources? -->

- [ ] No new security concerns
- [ ] IAM changes reviewed
- [ ] No secrets in code/logs
- [ ] Org policies considered

## Breaking Changes

<!-- Will this break existing infrastructure or workflows? -->

- [ ] No breaking changes
- [ ] Breaking changes (describe below)

<!-- If breaking, describe migration path -->

## Rollback Plan

<!-- How can this change be rolled back if needed? -->



## Pre-Merge Checklist

<!-- Ensure all items are checked before requesting review -->

- [ ] Code follows module conventions and standards
- [ ] All files are properly formatted (`terraform fmt`)
- [ ] Variable names are descriptive and follow naming conventions
- [ ] Outputs are documented if added/changed
- [ ] README updated if module behavior changed
- [ ] No sensitive data (credentials, keys, etc.) in code
- [ ] Cost impact considered and acceptable
- [ ] Tested locally before pushing
- [ ] CI/CD checks are passing
- [ ] Appropriate labels added to PR

## Additional Notes

<!-- Any additional context, concerns, or information for reviewers -->



---

<!--
For Reviewers:
- Verify plan output shows expected changes
- Check for security implications
- Confirm naming conventions followed
- Validate cost impact is acceptable
- Ensure proper documentation
-->
