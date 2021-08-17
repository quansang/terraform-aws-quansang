resource "aws_sns_topic" "sns_topic" {
  name         = var.sns_topic_name
  display_name = "${var.sns_topic_name} with ${var.service} policy"

  tags = {
    Stage   = var.env
    Service = var.service
    Project = var.project
  }
}

locals {
  codepipeline      = var.service == "codepipeline" ? "codestar-notifications" : null
  budgets           = var.service == "budgets" ? "budgets" : null
  cloudwatch_events = var.service == "cloudwatch-events" ? "events" : null

  sns_topic_policy_service_identifiers = try(coalesce(local.codepipeline, local.budgets, local.cloudwatch_events), null)
}

data "aws_iam_policy_document" "sns_topic_policy" {
  count     = var.service == "codepipeline" || var.service == "budgets" || var.service == "cloudwatch-events" || var.service == "inspector" ? 1 : 0
  policy_id = "__custom_policy_ID"

  dynamic "statement" {
    for_each = var.service == "codepipeline" || var.service == "budgets" || var.service == "cloudwatch-events" ? [1] : []
    content {
      actions = [
        "SNS:Publish",
      ]

      effect = "Allow"

      principals {
        type        = "Service"
        identifiers = ["${local.sns_topic_policy_service_identifiers}.amazonaws.com"]
      }

      resources = [
        aws_sns_topic.sns_topic.arn,
      ]

      sid = "_${replace(var.service, "-", "_")}_service_access_ID"
    }
  }

  dynamic "statement" {
    for_each = var.service == "inspector" || var.service == "cloudwatch-events" /*Note: Add cloudwatch-events condition for only this project */ ? [1] : []
    content {
      actions = [
        "SNS:Publish",
        "SNS:Subscribe",
        "SNS:Receive"
      ]

      effect = "Allow"

      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${var.inspector_region_id}:root"]
      }

      resources = [
        aws_sns_topic.sns_topic.arn,
      ]

      sid = "_inspector_service_access_ID"
    }
  }

  statement {
    actions = [
      "SNS:Subscribe",
      "SNS:SetTopicAttributes",
      "SNS:RemovePermission",
      "SNS:Receive",
      "SNS:Publish",
      "SNS:ListSubscriptionsByTopic",
      "SNS:GetTopicAttributes",
      "SNS:DeleteTopic",
      "SNS:AddPermission",
    ]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceOwner"

      values = [
        var.account_id,
      ]
    }

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    resources = [
      aws_sns_topic.sns_topic.arn,
    ]

    sid = "__default_statement_ID"
  }
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  count = var.service == "codepipeline" || var.service == "budgets" || var.service == "cloudwatch-events" || var.service == "inspector" ? 1 : 0
  arn   = aws_sns_topic.sns_topic.arn

  policy = data.aws_iam_policy_document.sns_topic_policy[0].json
}
