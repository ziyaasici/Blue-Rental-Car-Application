output "ec2-public-ips" {
   value = aws_instance.ec2[*].public_ip
}
