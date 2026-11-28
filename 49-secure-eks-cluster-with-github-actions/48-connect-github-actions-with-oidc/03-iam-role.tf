resource "aws_iam_role" "github_actions_role" {
  name        = "github_actions_role"
  description = "IAM role assumed by GitHub Actions through OIDC"

  assume_role_policy = data.aws_iam_policy_document.github_trust_policy.json

  max_session_duration = 3600
}

data "aws_iam_policy_document" "github_actions_deploy_permissions" {

  # ECR authentication
  statement {
    effect = "Allow"

    actions = [
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]
  }

  # push docker images to a specific repository
  statement {
    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:CompleteLayerUpload",
      "ecr:InitiateLayerUpload",
      "ecr:PutImage",
      "ecr:UploadLayerPart"
    ]

    resources = [
      local.ecr_repo_arn
    ]
  }

  # Retrieve EKS cluster connection information
  statement {
    effect = "Allow"

    actions = [
      "eks:DescribeCluster"
    ]

    resources = [
      local.eks_cluster_arn
    ]
  }
}

resource "aws_iam_policy" "github_actions_deploy_policy" {
  name        = "github-actions-eks-deploy-policy"
  description = "Permissions to push images to ECR and discover EKS"

  policy = data.aws_iam_policy_document.github_actions_deploy_permissions.json
}

resource "aws_iam_role_policy_attachment" "github_deploy" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = aws_iam_policy.github_actions_deploy_policy.arn
}