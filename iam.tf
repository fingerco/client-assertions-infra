resource "aws_iam_role" "client-assertions-api" {
  name = "client-assertions-api"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

data "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"
}

data "aws_iam_policy_document" "client-assertions-api" {
  statement {
    actions = [
      "dynamodb:*",
    ]

    resources = [
      "${aws_dynamodb_table.assertion-failures.arn}",
      "${aws_dynamodb_table.assertion-failures.arn}/*",
      "${aws_dynamodb_table.prediction-failures.arn}",
      "${aws_dynamodb_table.prediction-failures.arn}/*",
      "${aws_dynamodb_table.people.arn}",
      "${aws_dynamodb_table.people.arn}/*"
    ]
  }
}

resource "aws_iam_policy" "client-assertions-api" {
  name        = "client-assertions-api"
  path        = "/"
  description = "client-assertions-api IAM policy"
  policy      = data.aws_iam_policy_document.client-assertions-api.json
}

resource "aws_iam_policy_attachment" "client-assertions-api" {
  name       = "client-assertions-api-attachment"
  roles      = [aws_iam_role.client-assertions-api.name]
  policy_arn = aws_iam_policy.client-assertions-api.arn
}
