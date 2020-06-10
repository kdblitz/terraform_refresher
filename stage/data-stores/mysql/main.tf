terraform {
  backend "s3" {
    bucket         = "ns-kelee-terraform-tutorial"
    key            = "stage/data-stores/mysql/terraform.tfstate"
    region         = "ap-northeast-1"

    dynamodb_table = "simple-server-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

module "mysql_module" {
  source = "../../../modules/data-stores/mysql"

  cluster_name = "simple_server_staging"
  db_username  = "admin"
  db_password  = var.db_password
}