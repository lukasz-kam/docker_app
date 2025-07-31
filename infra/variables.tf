variable "aws_region" {
  description = "The AWS region for the infrastructure."
  type        = string
  default     = "eu-central-1"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]{1,2}$", var.aws_region))
    error_message = "The AWS region must be in a valid format (e.g., 'us-east-1', 'eu-central-1')."
  }
}

variable "subnet_az_a" {
  description = "AZ for the public subnet"
  type        = string
  default     = "eu-central-1a"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]{1,2}[a-z]$", var.subnet_az_a))
    error_message = "The Availability Zone (AZ) must be in a valid AWS format (e.g., 'us-east-1a', 'eu-central-1b'). It should start with a region prefix and end with a lowercase letter."
  }
}

variable "subnet_az_b" {
  description = "AZ for the public subnet"
  type        = string
  default     = "eu-central-1b"

  validation {
    condition     = can(regex("^[a-z]{2}-[a-z]+-[0-9]{1,2}[a-z]$", var.subnet_az_b))
    error_message = "The Availability Zone (AZ) must be in a valid AWS format (e.g., 'us-east-1a', 'eu-central-1b'). It should start with a region prefix and end with a lowercase letter."
  }
}

variable "vpc_name" {
  description = "Name for the VPC."
  type        = string
  default     = "python-vpc"
}

variable "repo_name" {
  description = "Name for the ECR repository."
  type        = string
  default     = "python-repo"
}