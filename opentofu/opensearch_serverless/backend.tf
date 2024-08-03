terraform {

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