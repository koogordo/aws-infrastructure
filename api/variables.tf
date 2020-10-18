// API Bucket
variable "api-s3-bucket-name" {
  type = string
  default = ""
}

// API Lambda
variable "api-lambda-name" {
  type = string
  default = ""
}
variable "api-lambda-description" {
  type = string
  default = ""
}
variable "api-lambda-artifacts-dir" {
  type = string
  default = ""
}
variable "api-lambda-source-path" {
  type = string
  default = ""
}
variable "api-lambda-runtime" {
  type = string
  default = ""
}
variable "api-lambda-handler" {
  type = string
  default = ""
}
variable "api-lambda-policy-name" {
  type = string
  default = ""
}

// API Gateway
variable "api-gateway-version" {
  type = string
  default = ""
}
variable "api-gateway-name" {
  type = string
  default = ""
}
variable "api-gateway-description" {
  type = string
  default = ""
}

// API Gateway CORS configuration
variable "api-gateway-cors-config-allow-headers" {
  type = set(string)
  default = [""]
}
variable "api-gateway-cors-config-allow-methods" {
  type = set(string)
  default = [""]
}
variable "api-gateway-cors-config-allow-origins" {
  type = set(string)
  default = [""]
}

variable "api-lambda-role-name" {
  type = string
  default = ""
}

variable "api-dynamodb-table-name" {
  type =string
  default = ""
}
