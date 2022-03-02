# ECR Repository
resource "aws_ecr_repository" "this" {
  name                 = "${var.ecr_repository}"
  image_tag_mutability = "${var.tag_mutability}"
  image_scanning_configuration {
    scan_on_push = false
  }
}

# ECR Repository Policy
resource "aws_ecr_repository_policy" "this" {
  repository = aws_ecr_repository.this.name
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowPushPull",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${var.ecr_account_id}:root",
          "arn:aws:iam::${var.app_account_id}:root"
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
  repository = aws_ecr_repository.this.name

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