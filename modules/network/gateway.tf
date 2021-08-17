#1. NAT GATEWAY for private subnet
resource "aws_eip" "nat_gateway_eip" {
  count = var.private_cidrs != null ? (var.only_one_nat_gateway == true ? 1 : length(var.private_cidrs)) : 0
  vpc   = true

  tags = {
    Name  = "${var.project}-eip-nat-gateway-${count.index + 1}-${var.env}"
    Stage = var.env
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_nat_gateway" "nat_gateway" {
  count         = var.private_cidrs != null ? (var.only_one_nat_gateway == true ? 1 : length(var.private_cidrs)) : 0
  allocation_id = aws_eip.nat_gateway_eip[count.index].id
  subnet_id     = aws_subnet.subnet_public[count.index].id

  tags = {
    Name  = "${var.project}-nat-gateway-${count.index + 1}-${var.env}"
    Stage = var.env
  }

  lifecycle {
    create_before_destroy = true
  }
}

#2. INTERNET GATEWAY for public subnet
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name  = "${var.project}-internet-gateway-${var.env}"
    Stage = var.env
  }
}

#3. VPC Endpoint
resource "aws_vpc_endpoint" "endpoint" {
  vpc_id       = aws_vpc.vpc.id
  service_name = "com.amazonaws.${var.region}.s3"

  tags = {
    Name  = "${var.project}-vpc-endpoint-${var.env}"
    Stage = var.env
  }
}

resource "aws_vpc_endpoint_route_table_association" "public" {
  route_table_id  = aws_route_table.route_public.id
  vpc_endpoint_id = aws_vpc_endpoint.endpoint.id
}


resource "aws_vpc_endpoint_route_table_association" "private" {
  count           = var.private_cidrs != null ? (var.only_one_nat_gateway == true ? 1 : length(var.private_cidrs)) : 0
  route_table_id  = var.only_one_nat_gateway == true ? aws_route_table.route_private[0].id : aws_route_table.route_private[count.index].id
  vpc_endpoint_id = aws_vpc_endpoint.endpoint.id
}
