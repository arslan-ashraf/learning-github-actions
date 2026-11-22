resource "aws_ecr_repository" "example_repo" {
  name                 = "example_repo"
  image_tag_mutability = "MUTABLE"

  # encryption_configuration {
  #   encryption_type = "KMS"
  #   kms_key         = "default"
  # }

  image_scanning_configuration {
    scan_on_push = false
  }
}

resource "aws_ecr_lifecycle_policy" "example_repo_policy" {
  repository = aws_ecr_repository.example_repo.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Remove untagged images after 1 day"
        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 1
        }
        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Keep only the latest 3 tagged images"
        selection = {
          tagStatus   = "any"
          countType   = "imageCountMoreThan"
          countNumber = 3
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}