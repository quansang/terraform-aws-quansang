resource "aws_security_group" "security_group" {
  name        = "${var.project}-${var.name}-sg-${var.env}"
  vpc_id      = var.vpc_id
  description = var.name

  tags = {
    Name  = "${var.project}-${var.name}-sg-${var.env}"
    Type  = var.type
    Stage = var.env
  }
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group_rule" "security_group_rule_egress" {
  for_each = {
    for value in var.security_group_rule_egress : value.description => value
    if try(value.enable, null) == null || try(value.enable, null) == true #Using variable: enable = true(false) when have different between DEV/STG/PROD environment
  }

  security_group_id = aws_security_group.security_group.id

  description              = each.value.description #Each description have different values
  protocol                 = each.value.protocol
  type                     = "egress"
  cidr_blocks              = try(each.value.cidr_blocks, null)
  source_security_group_id = try(each.value.source_security_group_id, null)
  from_port                = each.value.from_port
  to_port                  = each.value.to_port

  lifecycle {
    create_before_destroy = false
  }
}

resource "aws_security_group_rule" "security_group_rule_ingress" {
  for_each = {
    for value in var.security_group_rule_ingress : value.description => value
    if try(value.enable, null) == null || try(value.enable, null) == true #Using variable: enable = true(false) when have different between DEV/STG/PROD environment
  }

  security_group_id = aws_security_group.security_group.id

  description              = each.value.description #Each description have different values
  protocol                 = each.value.protocol
  type                     = "ingress"
  cidr_blocks              = try(each.value.cidr_blocks, null)
  source_security_group_id = try(each.value.source_security_group_id, null)
  from_port                = each.value.from_port
  to_port                  = each.value.to_port

  lifecycle {
    create_before_destroy = false
  }
}
