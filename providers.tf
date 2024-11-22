terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.73.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  shared_config_files = ["/Users/jeff.rodenburg/.aws/ex/test.config"]
  profile = "test"
}
