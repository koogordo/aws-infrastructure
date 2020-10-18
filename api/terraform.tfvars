// API Bucket
api-s3-bucket-name = "koo-api-artifacts"

// API Lambda
api-lambda-name = "api-lambda"
api-lambda-description = "Main api lambda function"
api-lambda-artifacts-dir = "artifacts/"
api-lambda-source-path = "/Users/lc5617748/PyCharmProjects/generic_handler"
api-lambda-runtime = "python3.8"

// API Gateway
api-gateway-version = "v2.0"
api-gateway-name = "api-gateway"
api-gateway-description = "Main api gateway"


// API Gateway CORS configuration
api-gateway-cors-config-allow-headers = ["*"]
api-gateway-cors-config-allow-methods = ["*"]
api-gateway-cors-config-allow-origins = ["*"]

api-lambda-role-name = "api-lambda-role"
api-lambda-handler = "hello_world.app.lambda_handler"
api-lambda-policy-name = "api-lambda-policy"