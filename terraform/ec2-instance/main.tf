provider "aws" {
  region = "sa-east-1"
}

data "http" "ifconfigme" {
    url = "http://ifconfig.me"
}

resource "tls_private_key" "key" {
  algorithm = "RSA"
}

resource "aws_key_pair" "key_pair" {
  key_name   = "instance-terraform-key"
  public_key = tls_private_key.key.public_key_openssh
  
  provisioner "local-exec" {
    command = "echo '${tls_private_key.key.private_key_pem}' > ~/.ssh/instance-terraform-key.pem"
  }
}

module "security_group" {
    source        = "clouddrove/security-group/aws"
    version       = "0.15.0"
    name          = var.security_group_name
    environment   = var.environment
    protocol      = var.protocol
    label_order   = var.label_order
    vpc_id        = var.vpc_id
    allowed_ip    = ["${chomp(data.http.ifconfigme.body)}/32"]
    allowed_ipv6  = var.allowed_ipv6 
    allowed_ports = var.allowed_ports
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = var.instance_name

  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.key_pair.key_name
  monitoring             = var.instance_monitoring
  vpc_security_group_ids = [module.security_group.security_group_ids]
  subnet_id              = var.subnet_id

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
