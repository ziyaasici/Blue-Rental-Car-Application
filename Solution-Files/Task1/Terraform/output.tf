# output "Environment" {
#   value = "${terraform.workspace}"
# }

output "ec2-public-ips" {
    value = "${terraform.workspace}-${aws_instance.ec2[*]}-ip: ${aws_instance.ec2[*].public_ip}"
}
