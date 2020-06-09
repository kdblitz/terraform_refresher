provider "aws" {
  region = "ap-northeast-1"
}

terraform {
  backend "s3" {
    bucket         = "ns-kelee-terraform-tutorial"
    key            = "global/s3/terraform.tfstate"
    region         = "ap-northeast-1"

    dynamodb_table = "simple-server-locks"
    encrypt        = true
  }
}

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
