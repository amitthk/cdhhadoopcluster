resource "aws_instance" "cdh_worker" {
    ami = "${var.ami_id}"
    instance_type = "${var.cdh_worker_instance_type}"
    key_name = "${var.aws_keypair_name}"
    associate_public_ip_address = true
    availability_zone = "${var.availability_zone}"
    count = "${var.cdh_worker_count}"
    vpc_security_group_ids = ["${aws_security_group.cdhstack_public.id}","${aws_security_group.cdhstack_private.id}"]
    subnet_id="${aws_subnet.private_nat_1.id}"

  tags {
      Name = "cdh_worker-${count.index}"
      Description = "cdh_worker-${count.index}"
  }
  


  ebs_block_device {
    device_name = "/dev/sda1"
    delete_on_termination = true
    volume_size = "${var.worker_block_device_size}"
  }
  volume_tags {
      Name = "cdh_worker-${count.index}"
  }
  root_block_device {
    delete_on_termination = true
 }
  provisioner "local-exec" {
    command = "aws ec2 create-tags --resources ${self.id} --tags Key=Name,Value=cdh_worker-${count.index}"

    environment {
      AWS_ACCESS_KEY_ID = "${var.aws_access_key}"
      AWS_SECRET_ACCESS_KEY = "${var.aws_secret_key}"
      AWS_DEFAULT_REGION = "${var.region}"
    }
  }
}

resource "null_resource" "after-cdh_worker" {
  depends_on = ["aws_instance.cdh_worker"]
  provisioner "local-exec" {
    command = "echo ' cdh_workers ${join(",",aws_instance.cdh_worker.*.id)} ${join(",",aws_instance.cdh_worker.*.public_ip)} ${join(",",aws_instance.cdh_worker.*.private_ip)}' >> inventory.txt"
  }
}