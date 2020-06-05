provider "aws" {
  region = "ap-northeast-1"
}

variable "server_port" {
  description = "Server port for http request"
  type        = number
  default     = 8080
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

resource "aws_launch_configuration" "server_config" {
  image_id        = "ami-0278fe6949f6b1a06"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.server_secgroup.id]

  user_data = <<-EOF
              #!/bin/bash  
              echo "Hello world!" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

resource "aws_autoscaling_group" "server_asg" {
  launch_configuration = aws_launch_configuration.server_config.name
  vpc_zone_identifier  = data.aws_subnet_ids.default.ids

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "simple-server-asg"
    propagate_at_launch = true
  }
}

/**
output "public_ip" {
  description = "IP address of web server"
  value = aws_instance.server_instance.public_ip
}

*/