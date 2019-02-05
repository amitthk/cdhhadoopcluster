resource "aws_spot_instance_request" "spot_cdh_master" {
    ami = "${var.ami_id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.aws_keypair_name}"
    count = "${var.spot_cdh_master_count}"
    spot_price = "${var.spot_price}"
    security_groups = ["${aws_security_group.cdhstack.name}"]

  tags {
      Name = "spot_cdh_master-${count.index}"
      Description = "spot_cdh_master-${count.index}"
  }
  
  volume_tags {
      Name = "spot_cdh_master-${count.index}"
  }
}

resource "null_resource" "after-spot_cdh_master" {
  depends_on = ["aws_spot_instance_request.spot_cdh_master"]
  provisioner "local-exec" {
    command = "echo ' spot_cdh_masters ${join(",",aws_spot_instance_request.spot_cdh_master.*.id)} ${join(",",aws_spot_instance_request.spot_cdh_master.*.public_ip)}' >> inventory.txt"
  }
}