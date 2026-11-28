resource "aws_eks_access_entry" "github_deploy" {
  cluster_name      = local.eks_cluster_name
  principal_arn     = aws_iam_role.github_actions_role.arn
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "github_deploy" {
  cluster_name  = local.eks_cluster_name
  principal_arn = aws_iam_role.github_actions_role.arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSEditPolicy"

  access_scope {
    type = "namespace"

    namespaces = [
      "default"
    ]
  }

  depends_on = [
    aws_eks_access_entry.github_deploy
  ]
}