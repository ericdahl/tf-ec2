output "aws_instance_default_public_ip" {
  value = "${aws_instance.default.public_ip}"
}

output "data.aws_ami.ecs.image_id" {
  value = "${data.aws_ami.ecs.image_id}"
}

output "aws_ami.freebsd_11.image_id" {
  value = "${data.aws_ami.freebsd_11.image_id}"
}

output "data.aws_ami.centos_7.image_id}" {
  value = "${data.aws_ami.centos_7.image_id}"
}

output "data.aws_ami.ubuntu.image_id" {
  value = "${data.aws_ami.ubuntu.image_id}"
}
