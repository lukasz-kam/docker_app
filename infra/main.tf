resource "aws_vpc" "main" {
  cidr_block           = "10.1.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name      = var.vpc_name
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.1.0/24"
  availability_zone = var.subnet_az_a

  tags = {
    Name      = "${var.vpc_name}_PublicSubnetA"
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.2.0/24"
  availability_zone = var.subnet_az_b

  tags = {
    Name      = "${var.vpc_name}_PublicSubnetB"
    ManagedBy = "Terraform"
  }
}

resource "aws_subnet" "private_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.1.3.0/24"
  availability_zone = var.subnet_az_a

  tags = {
    Name      = "${var.vpc_name}_PrivateSubnetA"
    ManagedBy = "Terraform"
  }
}

module "ecr_repo" {
  source     = "git@git.epam.com:lukasz_kaminski1/terraform-modules.git//modules/ecr?ref=main"
  repo_name  = var.repo_name
  aws_region = var.aws_region
}
