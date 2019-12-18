provider "aws" {
    region = "${var.region}"
    access_key ="${var.aws_access_key}"
    secret_key ="${var.aws_secret_key}"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_keypair_name" {}
variable "region" {}
variable "cdh_master_instance_type" {}
variable "cdh_worker_instance_type" {}
variable "cdh_stack_name" {}
variable "ami_id" {}
variable "public_subnets_cidr_blocks" {}
variable "private_subnets_cidr_blocks" {}
variable "cdh_master_count" {}
variable "cdh_worker_count" {}
variable "ingress_from_port" {
    default = 0
}
variable "ingress_to_port" {
    default = 65535
}

variable "availability_zone" {
  default = "ap-southeast-1a"
}
variable "vpc_cidr" {
  
}
variable "master_block_device_size" {
  default = 80
}

variable "worker_block_device_size" {
  default = 80
}

variable "cdh_scm_instance_type" {
  default = "t3.large"
}
