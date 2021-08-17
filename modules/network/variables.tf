#modules/network/variables.tf
#basic
variable "env" {}
variable "project" {}
variable "region" {}

#vpc
variable "vpc_cidr" {}

#subnet
variable "private_cidrs" { default = null }
variable "public_cidrs" {}
variable "only_one_nat_gateway" { default = true } #Set "default = false" if want NAT Gateway number = AZ number

#vpc-flow-log
variable "vpc_flow_log_s3_bucket_arn" { default = null }

#vpc-peering-connection
variable "peer_vpc_cidr" { default = null }
variable "vpc_peering_connection_id" { default = null }

