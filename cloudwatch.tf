resource "aws_cloudwatch_log_group" "client-assertions-api" {
  name = "client-assertions-api-svc"
  retention_in_days = 7
}
