terraform {

    # Setting the backend remote
    backend "remote" {

        # Setting the Scalr hostname and organization (environment) name
        hostname = "dkhundley.scalr.io"
        organization = "stream-demo"

        # Setting the name of the workspace
        workspaces {
            name = "stream_iam_role"
        }
    }

    # Downloading the required resource proivders
    required_providers {
        aws = {
            source = "hashicorp/aws"
        }
    }
}

# Setting the default AWS region
provider "aws" {
    region = "us-east-1"
}