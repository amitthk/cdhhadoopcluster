module "cdhstack_spot" {
  source = "./modules/cdhstack_spot"

  spot_price = "${var.spot_price}"
  aws_access_key = "${var.aws_access_key}"
  aws_secret_key = "${var.aws_secret_key}"
  aws_keypair_name = "${var.aws_keypair_name}"
  region = "${var.region}"
  availability_zone = "${var.availability_zone}"
  instance_type = "${var.instance_type}"
  vpc_id = "${var.vpc_id}"
  cdh_stack_name = "${var.cdh_stack_name}"
  ami_id = "${var.ami_id}"
  public_subnets_cidr_blocks = "${var.public_subnets_cidr_blocks}"
  private_subnets_cidr_blocks = "${var.private_subnets_cidr_blocks}"
  spot_cdh_master_count = "${var.spot_cdh_master_count}"
  spot_cdh_worker_count = "${var.spot_cdh_worker_count}"
  spot_cdh_master_volume_size = "${var.spot_cdh_master_volume_size}"
  spot_cdh_worker_volume_size = "${var.spot_cdh_worker_volume_size}"
  ingress_from_port = "${var.ingress_from_port}"
  ingress_to_port = "${var.ingress_to_port}"
  vpc_cidr = "${var.vpc_cidr}"
}