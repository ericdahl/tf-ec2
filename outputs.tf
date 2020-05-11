output "aws_instance_default_public_ip" {
  value = aws_instance.default.public_ip
}

output "data_aws_ami_ecs_image_id" {
  value = data.aws_ami.ecs.image_id
}

output "aws_ami_freebsd_12_image_id" {
  value = data.aws_ami.freebsd_12.image_id
}

output "data_aws_ami_centos_7_image_id" {
  value = data.aws_ami.centos_7.image_id
}

output "data_aws_ami_ubuntu_image_id" {
  value = data.aws_ami.ubuntu.image_id
}

