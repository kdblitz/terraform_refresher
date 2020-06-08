provider "aws" {
  region = "ap-northeast-1"
}

variable "server_port" {
  description = "Server port for http request"
  type        = number
  default     = 8080
}

/*
terraform {
  backend "s3" {
    bucket         = "ns-kelee-terraform-tutorial"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-northeast-1"

    dynamodb_table = "simple-server-locks"
    encrypt        = true
  }
}
*/

resource "aws_s3_bucket" "terraform_state" {
  bucket = "ns-kelee-terraform-tutorial"

  /*lifecycle {
    prevent_destroy = true
  }*/

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "aws_dynamodb_table" "terraform_locks" {
  name         = "simple-server-locks"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
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

  target_group_arns = [aws_lb_target_group.server_asg.arn]
  health_check_type = "ELB"

  min_size = 2
  max_size = 10

  tag {
    key                 = "Name"
    value               = "simple-server-asg"
    propagate_at_launch = true
  }
}

resource "aws_lb" "server_lb" {
  name               = "simple-server-alb"
  load_balancer_type = "application"
  subnets            = data.aws_subnet_ids.default.ids
  security_groups    = [aws_security_group.alb_secgroup.id]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.server_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}

resource "aws_security_group" "alb_secgroup" {
  name = "simple-server-alb-secgroup"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port  = 0
    to_port    = 0
    protocol   = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "server_asg" {
  name = "simple-server-asg"
  port = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_listener_rule" "server_lb" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type  = "forward"
    target_group_arn = aws_lb_target_group.server_asg.arn
  }
}

output "s3_bucket_arn" {
  description = "ARN for s3 backend state"
  value       = aws_s3_bucket.terraform_state.arn
}

output "dynamodb_table_name" {
  description = "Name of dynamodb table"
  value       = aws_dynamodb_table.terraform_locks.name
}

output "alb_dns" {
  description = "DNS of load balancer for web server"
  value = aws_lb.server_lb.dns_name
}