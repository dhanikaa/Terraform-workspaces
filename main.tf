provider "aws" {
  region = "eu-north-1"
}

variable "ami_value" {
  description = "ami of the EC2 instance"
}

variable "instance_type_value" {
  description = "type of the EC2 instance"
  type = map(string)

  default = {
    "dev" = "t3.micro"
    "stage" = "t3.nano"
    "prod" = "t3.medium"
  }
}

module "ec2_instance" {
    source = "./modules/ec2-instance"
    ami_value = var.ami_value
    instance_type_value = lookup(var.instance_type_value, terraform.workspace, "t3.micro")
}