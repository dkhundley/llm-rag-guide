terraform {

    # Setting the backend remote
    backend "remote" {

        # Setting the Scalr hostname and organization (environment) name
        hostname = "dkhundley.scalr.io"
        organization = "dkhundley-aws"

        workspaces {
            name = "dkhundley-opensearch-vectorstore"
        }
    }

    # Downloading the required resource providers
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