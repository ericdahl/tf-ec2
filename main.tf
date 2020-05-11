provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "github.com/ericdahl/tf-module-vpc"
}

data "aws_ami" "ecs" {
  most_recent = true

  owners = [591542846629]

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

data "aws_ami" "freebsd_12" {
  owners = [782442783595]

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["FreeBSD 12.1-RELEASE-amd64"]
  }

  most_recent = true
}

data "aws_ami" "centos_7" {
  most_recent = true

  owners = [410186602215]

  filter {
    name = "name"

    values = [
      "CentOS Linux 7 x86_64*",
    ]
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  owners = [099720109477]

  filter {
    name = "name"

    values = [
      "ubuntu/images/hvm-ssd/ubuntu-zesty-17.04*",
    ]
  }
}

resource "aws_key_pair" "default" {
  key_name   = "tf-ec2"
  public_key = var.public_key
}

resource "aws_instance" "default" {
  subnet_id     = module.vpc.subnet_public1
  ami           = data.aws_ami.ecs.image_id
  instance_type = "t2.medium"

  vpc_security_group_ids = [
    module.vpc.sg_allow_egress,
    module.vpc.sg_allow_22,
    module.vpc.sg_allow_80,
  ]

  key_name = aws_key_pair.default.key_name
}

