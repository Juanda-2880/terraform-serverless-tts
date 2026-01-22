variable "region" {
    description = "The AWS region to deploy resources in."
    type        = string
    default     = "us-east-1"
}

variable "resource_name" {
    description = "Resources Name"
    type        = string
    default     = "serverless-tts-polly-demo-2880"
}