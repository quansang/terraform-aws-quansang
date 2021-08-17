#1.1 Private Subnet - Route Table
resource "aws_subnet" "subnet_private" {
  count             = var.private_cidrs != null ? length(var.private_cidrs) : 0
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_cidrs[count.index]

  tags = {
    Name  = "${var.project}-subnet-private-${count.index + 1}-${var.env}"
    Stage = var.env
  }
}

resource "aws_route_table" "route_private" {
  count = var.private_cidrs != null ? (var.only_one_nat_gateway == true ? 1 : length(var.private_cidrs)) : 0

  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway[count.index].id
  }

  dynamic "route" { #Must have VPC Peering Connection id first
    for_each = var.vpc_peering_connection_id != null ? [1] : []
    content {
      vpc_peering_connection_id = var.vpc_peering_connection_id
      cidr_block                = var.peer_vpc_cidr
    }
  }

  tags = {
    Name  = "${var.project}-route-private-${count.index + 1}-${var.env}"
    Stage = var.env
  }
}

resource "aws_main_route_table_association" "main_route_private" {
  vpc_id         = aws_vpc.vpc.id
  route_table_id = aws_route_table.route_private[0].id
}

resource "aws_route_table_association" "private" {
  count          = var.private_cidrs != null ? length(aws_subnet.subnet_private) : 0
  subnet_id      = aws_subnet.subnet_private[count.index].id
  route_table_id = var.only_one_nat_gateway == true ? aws_route_table.route_private[0].id : aws_route_table.route_private[count.index].id
}
