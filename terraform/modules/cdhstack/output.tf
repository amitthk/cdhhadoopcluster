
output "cdhstack_bastion" {
  value = "${aws_instance.cdhstack_bastion.*.public_ip}"
}
output "cdh_scm" {
  value = "${aws_instance.cdh_scm.*.public_ip}"
}
output "cdh_master" {
  value = "${aws_instance.cdh_master.*.public_ip}"
}

output "cdh_worker" {
  value = "${aws_instance.cdh_worker.*.public_ip}"
}