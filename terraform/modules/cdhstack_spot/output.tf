output "spot_cdh_scm" {
  value = "${aws_spot_instance_request.spot_cdh_scm.*.public_ip}"
}

output "spot_cdh_master" {
  value = "${aws_spot_instance_request.spot_cdh_master.*.public_ip}"
}

output "spot_cdh_worker" {
  value = "${aws_spot_instance_request.spot_cdh_worker.*.public_ip}"
}

output "spot_cdh_scm_private_ip" {
  value = "${aws_spot_instance_request.spot_cdh_scm.*.private_ip}"
}

output "spot_cdh_master_private_ip" {
  value = "${aws_spot_instance_request.spot_cdh_master.*.private_ip}"
}

output "spot_cdh_worker_private_ip" {
  value = "${aws_spot_instance_request.spot_cdh_worker.*.private_ip}"
}