provider "aws" {
    region = "${var.region}"
    access_key ="${var.aws_access_key}"
    secret_key ="${var.aws_secret_key}"
}

resource "aws_security_group" "cdhstack" {
  name = "${format("%s-app-sg", var.name)}"

  vpc_id = "${var.vpc_id}"

  ingress {
    from_port   = "${var.app_port}"
    to_port     = "${var.app_port}"
    protocol    = "tcp"
    cidr_blocks = ["${var.public_subnets_cidr_blocks}", "${var.private_subnets_cidr_blocks}"]
  }

  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    cidr_blocks = ["${var.public_subnets_cidr_blocks}"]
  }

  egress {
    from_port   = "0"
    to_port     = "65535"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
  
  tags {
    Group = "${var.name}"
  }
}

resource "aws_instance" "tomcatserver" {
    ami = "${var.ami_id}"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"

  tags {
      Name = "tomcatserver"
      Description = "Used to deploy wars to tomcat"
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.tomcatserver.private_ip} >> file.txt"
  }

}
