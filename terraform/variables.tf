variable "region" {
  description = "The AWS region to deploy to"
  default = "ap-southeast-1"
}

variable "stackname" {
  description = "The name of the deployment stack"
  default = ""
}

variable "ami_id" {
    description = "AMI Id"
    default = "ami-8e0205f2"
}

variable "aws_access_key" {
  description = "The aws_access_key"
  default = ""
}

variable "aws_secret_key" {
  description = "The aws_secret_key"
  default = ""
}

variable "vpc_id" {
  description = "vpc_id"
  default = ""
}

variable "public_subnets_cidr_blocks" {
  description = "public_subnets_cidr_blocks"
  default = []
}

variable "public_subnets_cidr_blocks" {
  description = "public_subnets_cidr_blocks"
  default = []
}


variable "public_key" {
  default = ""
}
