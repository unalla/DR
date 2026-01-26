variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# variable "instance_id" {
#   description = "The ID of the primary EC2 instance to monitor"
#   type        = string
#   value       = aws_instance.primary.id
# }

#variable "sns_topic_arn" {
  #description = "The ARN of the SNS topic for DR alerts"
  #type        = string
#}