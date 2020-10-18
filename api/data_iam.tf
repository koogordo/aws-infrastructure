//data "aws_iam_role" "api-lambda-role" {
//  name = var.api-lambda-role-name
//  depends_on = [aws_iam_role.api-lambda-role]
//}
data "aws_iam_policy_document" "api-lambda-policy-document" {
  statement {
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "xray:PutTraceSegments",
      "xray:PutTelemetryRecords"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    actions = [
      "s3:PutObject",
      "s3:GetObject"
    ]
    resources = [
      "${module.api-s3-bucket.this_s3_bucket_arn}/*"
    ]
  }

  statement {
    actions = [
      "dynamodb:BatchGetItem",
      "dynamodb:BatchWriteItem",
      "dynamodb:GetItem",
      "dynamodb:DeleteItem",
      "dynamodb:Query",
      "dynamodb:PutItem",
      "dynamodb:Scan"
    ]
    resources = [
      "${module.api-dynamodb.this_dynamodb_table_arn}/*"
    ]
  }
}