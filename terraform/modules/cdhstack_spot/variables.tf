provider "aws" {
    region = "${var.region}"
    access_key ="${var.aws_access_key}"
    secret_key ="${var.aws_secret_key}"
}

variable "spot_price" {}
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_keypair_name" {}
variable "region" {}
variable "availability_zone" {}
variable "instance_type" {}
variable "vpc_id" {}
variable "cdh_stack_name" {}
variable "ami_id" {}
variable "vpc_cidr" {}
variable "public_subnets_cidr_blocks" {}
variable "private_subnets_cidr_blocks" {}
variable "spot_cdh_master_count" {}
variable "spot_cdh_worker_count" {}
variable "spot_cdh_master_volume_size" {}
variable "spot_cdh_worker_volume_size" {}
variable "ingress_from_port" {}
variable "ingress_to_port" {}

variable "scm_node_ip"{
    default = {
        "0" = "172.31.0.6"
        "1" = "172.31.0.7"
    }
}

variable "master_node_ips"{
        default = {
        "0" = "172.31.1.6"
        "1" = "172.31.1.7"
        "2" = "172.31.1.8"
        "3" = "172.31.1.9"
        "4" = "172.31.1.10"
        "5" = "172.31.1.11"
    }
}

variable "worker_node_ips"{
    default = {
        "0" = "172.31.1.50"
        "1" = "172.31.1.51"
        "2" = "172.31.1.52"
        "3" = "172.31.1.53"
        "4" = "172.31.1.54"
        "5" = "172.31.1.55"
        "6" = "172.31.1.56"
        "7" = "172.31.1.57"
    }
}