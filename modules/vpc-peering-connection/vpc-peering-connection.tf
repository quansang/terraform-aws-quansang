resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = var.vpc_id
  peer_owner_id = var.peer_owner_id
  peer_vpc_id   = var.peer_vpc_id

  tags = {
    Name  = "${var.project}-vpc-peering-${var.peer_vpc_id}-${var.env}"
    Stage = var.env
  }
}
