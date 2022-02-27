provider "aws" {
  profile = "default"
  region  = var.aws_region
}

provider "aws" {
  profile = "default"
  alias = "cert"
  region  = "us-east-1"
}
