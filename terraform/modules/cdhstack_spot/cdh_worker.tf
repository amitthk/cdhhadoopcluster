resource "aws_spot_instance_request" "spot_cdh_worker" {
    ami = "${var.ami_id}"
    instance_type = "${var.instance_type}"
    key_name = "${var.aws_keypair_name}"
    count = "${var.spot_cdh_worker_count}"
    security_groups = ["${aws_security_group.cdhstack.name}"]

  tags {
      Name = "spot_cdh_worker-${count.index}"
      Description = "spot_cdh_worker ${count.index}"
  }

  volume_tags {
      Name = "spot_cdh_worker-${count.index}"
  }
}

resource "null_resource" "after-spot_cdh_worker" {
  depends_on = ["aws_spot_instance_request.spot_cdh_worker"]
  provisioner "local-exec" {
    command = "echo ' spot_cdh_workers ${join(",",aws_spot_instance_request.spot_cdh_worker.*.id)} ${join(",",aws_spot_instance_request.spot_cdh_worker.*.public_ip)}' >> inventory.txt"
  }
}
