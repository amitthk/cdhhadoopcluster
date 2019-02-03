provider "aws" {
    region = "${var.region}"
    access_key ="${var.aws_access_key}"
    secret_key ="${var.aws_secret_key}"
}

variable "aws_access_key" {
  description = "The aws_access_key"
  default = ""
}

variable "aws_secret_key" {
  description = "The aws_secret_key"
  default = ""
}

variable "aws_keypair_name" {
  default = "amitthk_jenkinsmaster"
}

variable "region" {
  description = "The AWS region to deploy to"
  default = "ap-southeast-1"
}

variable "instance_type" {
  description = "The AMI Type"
  default = "t2.micro"
}

variable "vpc_id" {
  description = "vpc_id"
  default = "vpc-6f4d330b"
}

variable "stackname" {
  description = "The name of the deployment stack"
  default = ""
}

variable "ami_id" {
    description = "AMI Id"
    default = "ami-8e0205f2"
}

variable "public_subnets_cidr_blocks" {
  description = "public_subnets_cidr_blocks"
  default = []
}

variable "private_subnets_cidr_blocks" {
  description = "private_subnets_cidr_blocks"
  default = []
}