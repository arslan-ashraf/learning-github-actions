#!/usr/bin/bash

cd 40-secure-eks-cluster-with-vpc-endpoints


terraform init

terraform fmt -recursive

# terraform apply -auto-approve

# aws eks update-kubeconfig --region us-east-1 --name example_eks_cluster

cd ../48-connect-github-actions-with-oidc

terraform init

terraform fmt -recursive

# terraform apply -auto-approve