output "private_app_subnet_ids"{


value=aws_subnet.private_app[*].id


}