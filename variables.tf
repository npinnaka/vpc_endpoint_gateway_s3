locals {
  tags = {
    environment = "dev"
    app_name    = "VPC"
  }
}

variable "az" {
  description = "Availability zone for subnet(a,b,c,d,e,f)"
  default     = "a"
}

variable "region" {
  description = "AWS region for provider"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR for public subnet"
  default     = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR for private subnet"
  default     = "10.0.1.0/24"
}

variable "all_traffic" {
  description = "all traffic to public"
  default     = "0.0.0.0/0"
}

variable "ami" {
  description = "AMI ID for ec2 instance, this value changes for each region"
  default     = "ami-0ed9277fb7eb570c9"
}