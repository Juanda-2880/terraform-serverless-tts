terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    archive = {
      source  = "hashicorp/archive" 
      version = "~> 2.4.2"
    }
  }
}

provider "aws" {
    region = var.region
    #profile = "default"
    default_tags {
        tags = {
      Project = "Serverless-TTS"
      Environment = "Dev"
      ManagedBy = "Terraform"
    }
    }
}