// specify that we need aws provider
terraform {
    required_providers {
        aws = {
            source: "hashicorp/aws"
            version: "~>3.0"
        }
    }
}


