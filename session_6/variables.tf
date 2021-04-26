# Providers variables
variable "aws_region" {
  type        = string
  description = " aws region to deploys your infra"
}

# VPC variables
variable "vpc_cidr_block" {
  type        = string
  description = "cidr block for the vpc"
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

variable "rt_cidr_block" {
  type        = string
  description = "route table cidr block"
}

# Webserver variables
variable "instance_type" {
  type        = string
  description = "this is instance type"
}

# Route 53 variables
variable "zone_name" {
  description = "Name of route 53 zone"
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