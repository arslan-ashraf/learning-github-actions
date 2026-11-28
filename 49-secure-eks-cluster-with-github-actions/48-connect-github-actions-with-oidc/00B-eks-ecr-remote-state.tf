data "terraform_remote_state" "lab_40" {
  backend = "local"

  config = {
    path = "${path.module}/../40-secure-eks-cluster-with-vpc-endpoints/terraform.tfstate"
  }
}

locals {
  lab_40_outputs        = data.terraform_remote_state.lab_40.outputs
  eks_cluster_endpoint  = local.lab_40_outputs.eks_cluster_endpoint
  eks_cluster_name      = local.lab_40_outputs.eks_cluster_name
  certificate_authority = local.lab_40_outputs.eks_cluster_certificate_authority_data
  eks_cluster_arn       = local.lab_40_outputs.eks_cluster_arn
  ecr_repo_arn          = local.lab_40_outputs.ecr_repo_arn
}