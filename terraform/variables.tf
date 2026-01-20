variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "pinecone_api_key" {
  description = "API Key for Pinecone Vector Database"
  type        = string
  sensitive   = true # Prevents the key from being logged in plain text
}

variable "instance_id" {
  description = "The ID of the primary EC2 instance to monitor"
  type        = string
}

variable "sns_topic_arn" {
  description = "The ARN of the SNS topic for DR alerts"
  type        = string
}