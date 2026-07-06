terraform {

  required_providers {

    aws = {

      source  = "hashicorp/aws"
      version = "~> 5.0"

    }

  }

}


provider "aws" {

  region = "ap-south-1"

}


module "vpc" {

  source = "../../modules/vpc"


  vpc_cidr = "10.0.0.0/16"


  public_subnets = [

    "10.0.1.0/24",

    "10.0.2.0/24"

  ]


  private_app_subnets = [

    "10.0.11.0/24",

    "10.0.12.0/24"

  ]


  private_db_subnets = [

    "10.0.21.0/24",

    "10.0.22.0/24"

  ]


  azs = [

    "ap-south-1a",

    "ap-south-1b"

  ]

}
module "eks"{


source="../../modules/eks"


private_subnets=module.vpc.private_app_subnet_ids


}