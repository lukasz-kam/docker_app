data "aws_ami" "amazon" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

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
  cidr_block        = "10.1.4.0/24"
  availability_zone = var.subnet_az_a

  tags = {
    Name      = "${var.vpc_name}_PrivateSubnetA"
    ManagedBy = "Terraform"
  }
}

module "ecr_repo" {
  source     = "git@git.epam.com:lukasz_kaminski1/terraform-modules.git//modules/ecr?ref=v1.0.0"
  repo_name  = var.repo_name
  aws_region = var.aws_region
}

module "ecs_cluster" {
  source = "git@git.epam.com:lukasz_kaminski1/terraform-modules.git//modules/ecs_cluster?ref=v1.2.11"

  cluster_name        = var.cluster_name
  vpc_id              = aws_vpc.main.id
  public_subnets_ids  = [aws_subnet.public_a.id, aws_subnet.public_b.id]
  private_subnets_ids = [aws_subnet.private_a.id]
  ami_id              = data.aws_ami.amazon.id
  instance_type       = "t2.micro"
  container_image     = var.container_image
  max_asg             = 2
  desired_asg         = 1
}