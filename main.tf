provider "aws" {
  region = "ap-northeast-1"
}

variable "server_port" {
  description = "Server port for http request"
  type        = number
  default     = 8080
}

resource "aws_instance" "server_instance" {
  ami                    = "ami-0278fe6949f6b1a06"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.server_secgroup.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "hello world!" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  tags = {
    "Name" = "server-instance"
  }
}

resource "aws_security_group" "server_secgroup" {
  name = "server-secgroup"
  ingress {
    from_port   = var.server_port
	to_port     = var.server_port
	protocol    = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  description = "IP address of web server"
  value = aws_instance.server_instance.public_ip
}