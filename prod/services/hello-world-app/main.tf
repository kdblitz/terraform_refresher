provider "aws" {
    region = "ap-northeast-1"
}

module "hello_world_app" {
  source = "../../../modules/services/hello-world-app"

  server_text = "staging text here!"

  environment = var.environment
  db_remote_state_bucket = "ns-kelee-terraform-tutorial"
  db_remote_state_key    = "prod/data-stores/mysql/terraform.tfstate"

  instance_type        = "m4.large"
  min_size             = 2
  max_size             = 10
  enable_autoscaling   = true

  custom_tags = {
    Owner = "my-team"
    DeployedBy = "terraform"
  }
}