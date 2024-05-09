resource "aws_security_group" "ec2-sec-grp" {
  name        = "Task444-Sec-Grp"
  description = "Task444 Security Group"
  tags = {
    Name = "Task444-Sec-Grp"
  }

  dynamic "ingress" {
    for_each = var.ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "TCP"
      cidr_blocks = var.cidr
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr
  }
}

resource "aws_instance" "ec2" {
  instance_type = var.instance_type
  ami = "ami-04b70fa74e45c3917"
  key_name = "Task4-Keypair"
  iam_instance_profile = "blue-rental-project-blue"
  vpc_security_group_ids = [aws_security_group.ec2-sec-grp.id]
  tags = {
    Project = "Blue-Rental-Car-Application-Project"
    Name = "Blue-Rental-Task4"
  }
}
