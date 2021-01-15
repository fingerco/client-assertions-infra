resource "aws_dynamodb_table" "assertion-failures" {
  name           = "assertion-failures"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  range_key      = "failed_at"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "failed_at"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }
}

resource "aws_dynamodb_table" "prediction-failures" {
  name           = "assertion-prediction-states"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "user_id"
  range_key      = "prediction_id"

  attribute {
    name = "user_id"
    type = "S"
  }

  attribute {
    name = "prediction_id"
    type = "S"
  }

  ttl {
    attribute_name = "time_to_exist"
    enabled        = true
  }
}

resource "aws_dynamodb_table" "people" {
  name           = "people"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"
  range_key      = "created_at"

  attribute {
    name = "id"
    type = "S"
  }

  attribute {
    name = "created_at"
    type = "S"
  }

  ttl {
    attribute_name = "TimeToExist"
    enabled        = true
  }
}
