# 1. Primary Instance Details
output "primary_instance_id" {
  description = "The ID of the main active EC2 instance."
  value       = aws_instance.primary.id
}

output "primary_public_ip" {
  description = "The public IP of the active instance for the AI to monitor."
  value       = aws_instance.primary.public_ip
}

# 2. Standby Instance Details
output "standby_instance_id" {
  description = "The ID of the standby failover instance."
  value       = aws_instance.standby.id
}

# 3. Pinecone Knowledge Base Details
output "pinecone_index_host" {
  description = "The endpoint URL for the Pinecone index where runbooks are stored."
  value       = pinecone_index.dr_knowledge.host
}

# 4. Monitoring & Alerting
output "cloudwatch_alarm_arn" {
  description = "The ARN of the health check alarm that triggers the DR process."
  value       = aws_cloudwatch_metric_alarm.primary_health_alarm.arn
}

output "sns_topic_arn" {
  description = "The ARN of the SNS topic used for AI notifications."
  value       = aws_sns_topic.dr_alerts.arn
}