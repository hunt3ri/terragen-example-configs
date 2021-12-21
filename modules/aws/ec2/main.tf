
module "this_sg" {
  # SG registry module https://registry.terraform.io/modules/terraform-aws-modules/security-group/aws/latest
  source               = "terraform-aws-modules/security-group/aws"
  version              = "~> 4.0"

  name                 = var.sg_name
  description          = var.sg_description
  vpc_id               = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_cidr_blocks  = var.ingress_cidr_blocks
  ingress_rules        = var.ingress_rules

  egress_rules         = ["all-all"]
}

resource "aws_instance" "this_instance" {
  # Create EC2 instance(s)
  count                       = var.instance_count
  ami                         = data.aws_ami.ubuntu_lts.id
  instance_type               = var.instance_type

  subnet_id                   = data.terraform_remote_state.vpc.outputs.public_subnet_ids[count.index]
  associate_public_ip_address = var.associate_public_ip_address
  vpc_security_group_ids      = [module.this_sg.security_group_id]

  tags = {
    Name = "${var.instance_name}${count.index + 1}"
    Environment = var.environment
  }
}

