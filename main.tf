provider "aws" {
  region = "us-west-1"
}

data "aws_ssm_parameter" "amazon_linux_2" {
  name = "/aws/service/ami-amazon-linux-latest/amzn-ami-hvm-x86_64-gp2"
}

data "aws_ssm_parameter" "ecs_optimized" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2/recommended/image_id"
}

resource "aws_key_pair" "default" {
  key_name   = "tf-ec2"
  public_key = var.public_key
}

resource "aws_instance" "default" {
  subnet_id     = var.subnet_id
  ami           = data.aws_ssm_parameter.ecs_optimized.value
  instance_type = "c5.large"

  vpc_security_group_ids = [
    aws_security_group.instance.id
  ]

  key_name = aws_key_pair.default.key_name
}

resource "aws_security_group" "instance" {
  name   = "tf-ec2"
  vpc_id = var.vpc_id
}

resource "aws_security_group_rule" "egress" {
  security_group_id = aws_security_group.instance.id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "allow_22" {
  security_group_id = aws_security_group.instance.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.admin_cidrs
}

resource "aws_security_group_rule" "allow_icmp" {
  security_group_id = aws_security_group.instance.id
  type              = "ingress"
  from_port         = -1 
  to_port           = -1 
  protocol          = "icmp"
  cidr_blocks       = var.admin_cidrs
}



