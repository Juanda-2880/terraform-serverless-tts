provider "AWS" {
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