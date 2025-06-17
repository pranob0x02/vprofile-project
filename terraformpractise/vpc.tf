module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.AWS_VPC_NAME
  cidr = var.AWS_VPC_CIDR

  azs             = var.AWS_ZONE
  private_subnets = var.AWS_VPC_PRIVATE_SUBNETS
  public_subnets  = var.AWS_VPC_PUBLIC_SUBNETS

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  map_public_ip_on_launch = true

  tags = {
    name    = var.AWS_VPC_NAME
    project = var.PROJECT_NAME
  }
}
