provider "aws" {
  region = "us-east-1"
}

module "api-s3-bucket" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-s3-bucket.git?ref=v1.15.0"

  bucket = var.api-s3-bucket-name
}

module "api-lambda" {
  source  = "git::https://github.com/terraform-aws-modules/terraform-aws-lambda.git?ref=v1.24.0"
  function_name = var.api-lambda-name
  description = var.api-lambda-description
  policy = data.aws_iam_policy_document.api-lambda-policy-document.json
  s3_bucket = module.api-s3-bucket.this_s3_bucket_arn
  artifacts_dir = var.api-lambda-artifacts-dir
  source_path = var.api-lambda-source-path
  runtime = var.api-lambda-runtime
  handler = var.api-lambda-handler
  depends_on = [module.api-s3-bucket]
}


resource "aws_lambda_permission" "api-gateway-lambda-invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.api-lambda.this_lambda_function_name
  principal     = "apigateway.amazonaws.com"

  # The "/*/*" portion grants access from any method on any resource
  # within the API Gateway REST API.
  source_arn = "${module.api-gateway.this_apigatewayv2_api_execution_arn}/*/*"
}

module "api-gateway" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-apigateway-v2.git?ref=v0.4.0"

  name = var.api-gateway-name
  api_version = var.api-gateway-version
  description = var.api-gateway-description
  create_api_domain_name = false
  cors_configuration = {
    allow_headers = var.api-gateway-cors-config-allow-headers
    allow_methods = var.api-gateway-cors-config-allow-methods
    allow_origins = var.api-gateway-cors-config-allow-origins
  }
  integrations = {
    "POST /" = {
      lambda_arn             = module.api-lambda.this_lambda_function_arn
      payload_format_version = "2.0"
      timeout_milliseconds   = 12000
    }

    "$default" = {
      lambda_arn = module.api-lambda.this_lambda_function_arn
    }
  }


}

module "api-dynamodb" {
  source = "git::https://github.com/terraform-aws-modules/terraform-aws-dynamodb-table.git?ref=v0.9.0"

  name      = var.api-dynamodb-table-name
  hash_key  = "partition_key"
  range_key = "sort_key"

  attributes = [
    {
      name = "partition_key"
      type = "S"
    },
    {
      name = "sort_key"
      type = "S"
    }
  ]

  global_secondary_indexes = [
    {
      name               = "SortKey"
      hash_key           = "sort_key"
      projection_type    = "ALL"
    }
  ]
}
//resource "aws_iam_role" "api-lambda-role" {
//  name = var.api-lambda-role-name
//  assume_role_policy = ""
//}
//resource "aws_iam_policy" "api-lambda-policy" {
//  policy = data.aws_iam_policy_document.api-lambda-policy-document.json
//  name = var.api-lambda-policy-name
//}


