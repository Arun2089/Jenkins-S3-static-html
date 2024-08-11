provider "aws" {
  profile = "default"
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a"]
  public_subnets  = ["10.0.101.0/24"]

  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
  }
}
