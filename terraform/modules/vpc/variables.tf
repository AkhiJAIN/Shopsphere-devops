variable "vpc_cidr"{


type = string


description = "CIDR block for VPC"

}
variable "public_subnets" {

type=list(string)

}


variable "private_app_subnets"{

type=list(string)

}


variable "private_db_subnets"{

type=list(string)

}


variable "azs"{

type=list(string)

}