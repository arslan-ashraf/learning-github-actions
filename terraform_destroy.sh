#!/usr/bin/bash

cd 48-connect-github-actions-with-oidc

terraform destroy -auto-approve

cd ../40-secure-eks-cluster-with-vpc-endpoints

terraform destroy -auto-approve