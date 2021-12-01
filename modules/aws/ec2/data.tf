data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket  = "{{ bucket }}"
    key     = "{{ lookups['vpc_statefile'] }}"
    profile = "{{ profile }}"
    region  = "{{ region }}"
  }
}

data "terraform_remote_state" "key_pair" {
  backend = "s3"
  config = {
    bucket  = "{{ bucket }}"
    key     = "{{ lookups['key_pair_statefile'] }}"
    profile = "{{ profile }}"
    region  = "{{ region }}"
  }
}

data "aws_ami" "hunter_labs_sandbox" {
  # Identify the latest labs sandbox image
  most_recent = true

  filter {
    name   = "name"
    values = ["hunter-labs-sandbox-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  # restrict search to ami's within our account
  owners = [var.aws_account]
}

data "aws_route53_zone" "hunter_labs_zone" {
  # IMPORTANT hunter-labs.net needs to be manually created on a new environment
  name = "hunter-labs.net."  # Note trailing '.' required to locate the record
  private_zone = false
}
