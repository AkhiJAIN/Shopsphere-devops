terraform {

  backend "s3" {

    bucket = "shopsphere-terraform-state-bucket"

    key = "dev/terraform.tfstate"

    region = "ap-south-1"

    dynamodb_table = "shopsphere-lock-table"

    encrypt = true

  }

}