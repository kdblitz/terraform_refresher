provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  backend "s3" {
    bucket         = "ns-kelee-terraform-tutorial"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "ap-northeast-1"

    dynamodb_table = "simple-server-locks"
    encrypt        = true
  }
}

resource "aws_db_instance" "db_server" {
  identifier_prefix = "simple-server"
  engine            = "mysql"
  allocated_storage = 10
  instance_class    = "db.t2.micro"
  name              = "server_db"
  username          = "admin"
  password          = var.db_password
}