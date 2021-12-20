data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "{{ bucket }}"
    key     = "{{ lookups['vpc_statefile'] }}"
    profile = "{{ profile }}"
    region  = "{{ region }}"
  }
}

data "aws_ami" "ubuntu_lts" {
  # Get latest ubuntu base image
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images*ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # ubuntu images owned as by this owner, you can test filter as follows:
  # aws ec2 describe-images --filters "Name=name,Values=ubuntu/images*ubuntu-focal-20.04-amd64-server-*"
  owners = ["099720109477"]
}