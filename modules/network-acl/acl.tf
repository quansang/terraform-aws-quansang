
resource "aws_network_acl" "acl" {
  vpc_id     = var.acl_vpc_id
  subnet_ids = var.acl_subnet_ids

  tags = {
    Name  = "${var.project}-acl-${var.acl_name}-${var.env}"
    Stage = var.env
  }
}

resource "aws_network_acl_rule" "acl_rule" {
  for_each = var.acl_rule

  network_acl_id = aws_network_acl.acl.id
  egress         = try(each.value["egress"], false)
  protocol       = try(each.value["protocol"], "tcp")
  rule_action    = try(each.value["rule_action"], "allow")
  rule_number    = each.value["rule_number"]
  cidr_block     = each.value["cidr_block"]
  from_port      = each.value["from_port"]
  to_port        = each.value["to_port"]
}

