terraform {
  backend "s3" {
    bucket         = "terraformstatee"
    key            = "eks/terraform.tfstate"
    region         = "eu-north-1"
    dynamodb_table = "terraform-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "eu-north-1"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "my-eks-cluster"
  cluster_version = "1.29"
  subnet_ids      = ["subnet-0b0cc2d8b401eae1e"]  # MUST be a list of strings
  vpc_id          = "vpc-05460da2bddc58546"
  # manage_aws_auth = true                          # usually recommended for single-node setups

  node_groups = {
    default = {
      desired_capacity = 1
      max_capacity     = 2
      min_capacity     = 1
      instance_types   = ["t3.medium"]
    }
  }
}
