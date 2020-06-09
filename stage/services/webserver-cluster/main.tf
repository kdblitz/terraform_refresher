provider "aws" {
    region = "ap-northeast-1"
}

module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"

  cluster_name           = "simple-server-staging"
  db_remote_state_bucket = "ns-kelee-terraform-tutorial"
  db_remote_state_key    = "stage/data-stores/mysql/terraform.tfstate"
}