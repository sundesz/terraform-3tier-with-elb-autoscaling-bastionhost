# Create SNS topic
resource "aws_sns_topic" "cpu_alarm_topic" {
  name = "cpu_alarm_topic"
}

# Subscribe email to SNS topic
resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.cpu_alarm_topic.arn
  protocol = "email"
  endpoint = var.sns_email
}