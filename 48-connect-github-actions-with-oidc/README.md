In this lab, we see how to connect a Github Actions pipeline to AWS.

To run this lab, copy this lab outside of the base directory `aws-labs-with-terraform`.  This is done because Github Actions requires that the CI workflow folder `.github/workflows/` is in the root directory.

This is why this Terraform lab is copied into `learning-github-actions`.

In the file `02-iam-trust-policy.tf`, we change the second condition's `values` to the current root directory `learning-gitub-actions`.

1. Run Terraform

2. Terraform will output `github_actions_role_arn`.  Copy that arn into Github secrets with key `AWS_GITHUB_ACTIONS_ROLE_ARN`.

3. Run the workflow manually from the console.

