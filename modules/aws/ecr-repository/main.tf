data "aws_caller_identity" "current" {}

# I'm using aws_caller_identity on both app_account_id and ecr_account_id just to simplify.
# Feel free to hard-code your AWS Account ID or to put some specific variable in place.
locals {
    app_account_id = data.aws_caller_identity.current.account_id
    ecr_account_id = data.aws_caller_identity.current.account_id
    ecr_repositories = toset([
        "my-app-1",
        "my-app-2"
    ])
}

# ECR Repository
resource "aws_ecr_repository" "this" {
  for_each             = local.ecr_repositories
  name                 = "${each.value}"
  image_tag_mutability = "MUTABLE" # MUTABLE or IMMUTABLE
  image_scanning_configuration {
    scan_on_push = false
  }
}

# ECR Repository Policy
resource "aws_ecr_repository_policy" "this" {
  for_each             = aws_ecr_repository.this
  repository           = aws_ecr_repository.this.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowPushPull",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${local.ecr_account_id}:root",
          "arn:aws:iam::${local.app_account_id}:root"
        ]
      },
      "Action": [
        "ecr:BatchCheckLayerAvailability",
        "ecr:BatchGetImage",
        "ecr:CompleteLayerUpload",
        "ecr:GetDownloadUrlForLayer",
        "ecr:InitiateLayerUpload",
        "ecr:PutImage",
        "ecr:UploadLayerPart"
      ]
    }
  ]
}
EOF
}

# ECR Lifecycle Policy
# Remove images without tags after 14 days
resource "aws_ecr_lifecycle_policy" "this" {
  for_each             = aws_ecr_repository.this
  repository           = aws_ecr_repository.this.name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Expire images older than 14 days",
      "selection": {
        "tagStatus": "untagged",
        "countType": "sinceImagePushed",
        "countUnit": "days",
        "countNumber": 14
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}