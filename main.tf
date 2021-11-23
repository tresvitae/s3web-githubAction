terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~>3.27"
        }
    }

    backend "s3" {
        bucket = "tresvitae"
        key    = "s3web-githubaction"
        region = "us-west-2"
    }
}

provider "aws" {
    profile = "default"
    region  = "eu-west-1"
}

resource "aws_s3_bucket" "s3Bucket" {
    bucket        = "s3web-githubaction"
    acl           = "public-read"
    force_destroy = true
    lifecycle {
      prevent_destroy = false
    }

    policy = file("bucketpolicy.json")
    
    website {
       index_document = "index.html"
   }
}