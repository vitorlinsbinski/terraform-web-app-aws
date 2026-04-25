data "aws_ami" "latest_ubuntu_ami" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

data "aws_vpc" "vpc_selected" {
  id = var.vpc_id
}

data "aws_subnet" "public_subnet_1_selected" {
  id = var.subnet_id
}