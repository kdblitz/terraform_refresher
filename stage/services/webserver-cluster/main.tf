terraform {
  backend "s3" {
    bucket         = "ns-kelee-terraform-tutorial"
    key            = "stage/services/webserver-cluster/terraform.tfstate"
    region         = "ap-northeast-1"

    dynamodb_table = "simple-server-locks"
    encrypt        = true
  }
}

provider "aws" {
    region = "ap-northeast-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = "server-staging"
  db_remote_state_bucket = "ns-kelee-terraform-tutorial"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type      = "t2.micro"
  min_size           = 2
  max_size           = 10
  enable_autoscaling = false

  custom_tags = {
    Owner = "my-team"
    DeployedBy = "terraform"
  }
}