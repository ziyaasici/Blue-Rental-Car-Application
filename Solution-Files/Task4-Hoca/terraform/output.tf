output "node_public_ip" {
    value = aws_instance.devops_project_instance.public_ip
}