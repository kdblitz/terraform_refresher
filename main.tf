provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_instance" "server_instance" {
  ami                    = "ami-0278fe6949f6b1a06"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.server_secgroup.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "hello world!" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  tags = {
    "Name" = "server-instance"
  }
}

resource "aws_security_group" "server_secgroup" {
  name = "server-secgroup"
  ingress {
    from_port   = 8080
	to_port     = 8080
	protocol    = "tcp"
	cidr_blocks = ["0.0.0.0/0"]
  }
}