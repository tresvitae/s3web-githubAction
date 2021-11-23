terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>3.27"
        }
    }

    required_version = ">=0.14.9"

    backend "s3" {
        bucket = "tresvitae"
        key = "s3web-githubaction"
        region = "us-west-2"
    }
}

provider "aws" {
    region = "ue-west-1"
}

resource "aws_s3_bucket" "s3Bucket" {
    bucket = "s3web-githubaction"
    acl    = "public-read"

    policy = <<EOF
{
    "id" : "MakePublic",
    "version" : "2012-10-17",
    "statement" : [
        {
            "action" : [
                "s3:GetObject"
            ],
            "effect" : "Allow",
            "resource" : "arn:aws:s3:::s3web-githubaction/*",
            "principal" : "*"
        }
    ]
}
EOF

    website {
        index_document = "index.html"
    }
}