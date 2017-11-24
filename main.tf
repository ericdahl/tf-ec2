provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "github.com/ericdahl/tf-module-vpc"
}

data "aws_ami" "ecs" {
  most_recent = true

  filter {
    name = "owner-alias"

    values = [
      "amazon",
    ]
  }

  filter {
    name = "name"

    values = [
      "*amazon-ecs-optimized*",
    ]
  }
}

data "aws_ami" "freebsd_11" {
  most_recent = true

  filter {
    name = "owner-id"

    values = [
      "118940168514",
    ]
  }

  filter {
    name = "name"

    values = [
      "FreeBSD 11.1-STABLE-amd64*",
    ]
  }
}

data "aws_ami" "centos_7" {
  most_recent = true

  filter {
    name = "owner-id"

    values = [
      "410186602215",
    ]
  }

  filter {
    name = "name"

    values = [
      "CentOS Linux 7 x86_64*",
    ]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "owner-id"

    values = [
      "099720109477",
    ]
  }

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd/ubuntu-zesty-17.04*",
    ]
  }
}

resource "aws_instance" "default" {
  subnet_id     = "${module.vpc.subnet_public1}"
  ami           = "${data.aws_ami.ecs.image_id}"
  instance_type = "t2.small"

  vpc_security_group_ids = [
    "${module.vpc.sg_allow_egress}",
    "${module.vpc.sg_allow_22}",
    "${module.vpc.sg_allow_80}",
  ]

  key_name = "${var.key_name}"
}
