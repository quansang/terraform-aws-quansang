#modules/vpc-peering-connection/variables.tf
#basic
variable "env" {}
variable "project" {}

#vpc-peering-connection
variable "vpc_id" {}
variable "peer_owner_id" {}
variable "peer_vpc_id" {}
