resource "aws_security_group" "test-sec-grp" {
  name        = "${var.environment}-Sec-Grp"
  description = "${var.environment} Security Group"
  tags = {
    Name = "${var.environment}-Sec-Grp"
  }

  dynamic "ingress" {
    for_each = var.ports

    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "test-ec2" {
  instance_type = var.instance_type
  ami = var.ami
  key_name = var.keypair
   vpc_security_group_ids = [aws_security_group.test-sec-grp.id]
  tags = {
    Name = "Blue-Rental-${var.environment}"
  }
}
