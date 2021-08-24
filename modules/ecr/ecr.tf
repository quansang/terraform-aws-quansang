# Create ECR
resource aws_ecr_repository ecr {
  name                 = "${var.project}-${var.ecr_name}-ecr-repository-${var.env}"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    Name  = "${var.project}-${var.ecr_name}-ecr-repository-${var.env}"
    Type  = var.ecr_type
    Stage = var.env
  }
}

# Lifecycle policy for ECR
data template_file ecr_lifecycle_policy_template {
  template = file("${var.ecr_lifecycle_policy_template}.json")
  vars     = var.ecr_lifecycle_policy_vars
}

resource aws_ecr_lifecycle_policy ecr_lifecycle_policy {
  repository = aws_ecr_repository.ecr.name
  policy     = data.template_file.ecr_lifecycle_policy_template.rendered
}

