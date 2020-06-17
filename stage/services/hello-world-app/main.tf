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

module "hello_world_app" {
  source = "../../../modules/services/hello-world-app"

  server_text = "staging text here!"

  environment = var.environment
  db_remote_state_bucket = "ns-kelee-terraform-tutorial"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"

  instance_type        = "t2.micro"
  min_size             = 2
  max_size             = 2
  enable_autoscaling   = false
}