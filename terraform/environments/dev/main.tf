terraform {

required_providers {

aws = {

source = "hashicorp/aws"

version = "~> 5.0"

}

}

}


provider "aws" {

region = "ap-south-1"

}

module "vpc"{


source = "../../modules/vpc"


vpc_cidr = "10.0.0.0/16"


}