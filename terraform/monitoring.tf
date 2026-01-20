resource "aws_cloudwatch_metric_alarm" "primary_health_alarm" {
  alarm_name          = "primary-instance-failure"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "1"
  metric_name         = "StatusCheckFailed"
  namespace           = "AWS/EC2"
  period              = "60" # Check every 1 minute
  statistic           = "Maximum"
  threshold           = "0"
  alarm_description   = "Triggered when the primary EC2 instance fails health checks."
  
  dimensions = {
    InstanceId = var.instance_id
  }

  # Action: Notify the SNS topic (which triggers your AI Runbook Optimizer)
  alarm_actions = [var.sns_topic_arn]
}