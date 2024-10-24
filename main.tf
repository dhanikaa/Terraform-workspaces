provider "aws" {
  region = "eu-north-1"
}

variable "ami_value" {
  description = "ami of the EC2 instance"
}

variable "instance_type_value" {
  description = "type of the EC2 instance"
}

module "ec2_instance" {
    source = "./modules/ec2-instance"
    ami_value = var.ami_value
    instance_type_value = var.instance_type_value
}