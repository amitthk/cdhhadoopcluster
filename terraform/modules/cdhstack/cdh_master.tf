resource "aws_instance" "cdh_master" {
    ami = "${var.ami_id}"
    instance_type = "${var.cdh_master_instance_type}"
    key_name = "${var.aws_keypair_name}"
    associate_public_ip_address = true
    availability_zone = "${var.availability_zone}"
    count = "${var.cdh_master_count}"
    vpc_security_group_ids = ["${aws_security_group.cdhstack_public.id}","${aws_security_group.cdhstack_private.id}"]
    subnet_id="${aws_subnet.private_nat_1.id}"

  tags {
      Name = "cdh_master-${count.index}"
      Description = "cdh_master-${count.index}"
  }
  


  ebs_block_device {
    device_name = "/dev/sda1"
    delete_on_termination = true
    volume_size = "${var.master_block_device_size}"
  }
  volume_tags {
      Name = "cdh_master-${count.index}"
  }
  root_block_device {
    delete_on_termination = true
 }
  provisioner "local-exec" {
    command = "aws ec2 create-tags --resources ${self.id} --tags Key=Name,Value=cdh_master-${count.index}"

    environment {
      AWS_ACCESS_KEY_ID = "${var.aws_access_key}"
      AWS_SECRET_ACCESS_KEY = "${var.aws_secret_key}"
      AWS_DEFAULT_REGION = "${var.region}"
    }
  }
}

resource "null_resource" "after-cdh_master" {
  depends_on = ["aws_instance.cdh_master"]
  provisioner "local-exec" {
    command = "echo ' cdh_masters ${join(",",aws_instance.cdh_master.*.id)} ${join(",",aws_instance.cdh_master.*.public_ip)} ${join(",",aws_instance.cdh_master.*.private_ip)}' >> inventory.txt"
  }
}