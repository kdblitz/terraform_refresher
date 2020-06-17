provider "aws" {
  region = "ap-northeast-1"
}

module "alb" {
  source = "../../modules/networking/alb"

  alb_name   = "example-alb"
  subnet_ids = data.aws_subnet_ids.default.ids
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}