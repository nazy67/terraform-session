# Providers variables
variable "aws_region" {
  type        = string
  description = "The region Terraform deploys your infra"
}

# VPC variables
variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "instance_tenancy" {
  type        = string
  description = "the tenancy of existing VPCs from dedicated to default instantly"
}

variable "is_enabled_dns_support" {
  type        = bool
  description = "enabling dns support"
}

variable "is_enabled_dns_hostnames" {
  type        = bool
  description = "enabling dns hostnames"
}

# Subnet variables
variable "aws_az_1a" {
  type        = string
  description = "The region Terraform deploys your infra"
}

variable "aws_az_1b" {
  type        = string
  description = "The region Terraform deploys your infra"
}

variable "aws_az_1c" {
  type        = string
  description = "The region Terraform deploys your infra"
}

variable "pub_cidr1_subnet" {
  type        = string
  description = "CIDR block for the  1st public subnet"
}

variable "pub_cidr2_subnet" {
  type        = string
  description = "CIDR block for the 2nd public subnet"
}

variable "pub_cidr3_subnet" {
  type        = string
  description = "CIDR block for the 2nd public subnet"
}

variable "priv_cidr1_subnet" {
  type        = string
  description = "CIDR block for the 1st private subnet"
}

variable "priv_cidr2_subnet" {
  type        = string
  description = "CIDR block for the 2nd private subnet"
}

variable "priv_cidr3_subnet" {
  type        = string
  description = "CIDR block for the 2nd private subnet"
}

# WordPress web and database variables
variable "instance_type" {
  type        = string
  description = "instance type"
}

variable "associate_public_ip_address" {
  type        = bool
  description = "associate public ip address"
}

# Security group rule variables
variable "web_sg_tcp_ports" {
  type = list(string)
}

variable "webdb_sg_tcp_ports" {
  type = list(string)
}

variable "egress_port" {
  description = "incoming port"
  type        = number
}

variable "ingress_protocol" {
  description = "intbound network"
  type        = string
}

variable "egress_protocol" {
  description = "outbound network"
  type        = string
}

variable "cidr_block" {
  description = "ingress/egress cidr block"
  type        = string
}

variable "in_traffic_type" {
  description = "ingress type"
  type        = string
}

variable "out_traffic_type" {
  description = "ingress type"
  type        = string
}

# Tags variables
variable "env" {
  type        = string
  description = "name of the environment"
}

variable "project_name" {
  type        = string
  description = "name of the project"
}

# Route 53 variables
variable "zone_name" {
  description = "Name of route 53 zone"
  type        = string
}