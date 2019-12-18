resource "aws_instance" "cdhstack_bastion" {
    ami = "${var.ami_id}"
    instance_type = "t2.micro"
    key_name = "${var.aws_keypair_name}"
    associate_public_ip_address = true
    availability_zone = "${var.availability_zone}"
    count = "1"
    vpc_security_group_ids = ["${aws_security_group.cdhstack_public.id}"]
    subnet_id="${aws_subnet.public_nat_1.id}"

  tags {
      Name = "cdhstack_bastion-${count.index}"
      Description = "cdhstack_bastion-${count.index}"
  }
  ebs_block_device {
    device_name = "/dev/sda1"
    delete_on_termination = true
  }
  volume_tags {
      Name = "cdhstack_bastion-${count.index}"
  }
  root_block_device {
    delete_on_termination = true
 }

  provisioner "local-exec" {
    command = "aws ec2 create-tags --resources ${self.id} --tags Key=Name,Value=cdhstack_bastion-${count.index}"

    environment {
      AWS_ACCESS_KEY_ID = "${var.aws_access_key}"
      AWS_SECRET_ACCESS_KEY = "${var.aws_secret_key}"
      AWS_DEFAULT_REGION = "${var.region}"
    }
  }
}



resource "null_resource" "after-cdhstack_bastion" {
  depends_on = ["aws_instance.cdhstack_bastion"]
  provisioner "local-exec" {
    command = "echo ' cdhstack_bastions ${join(",",aws_instance.cdhstack_bastion.*.id)} ${join(",",aws_instance.cdhstack_bastion.*.private_ip)} ${join(",",aws_instance.cdhstack_bastion.*.public_ip)}' >> inventory.txt"
  }
}