resource "aws_security_group_rule" "inbound-8080" {
  type = "ingress"
  to_port = 8080
  from_port = 8080
  protocol = "TCP"
  security_group_id = "sg-0a73d72299314a38e"
  cidr_blocks = ["0.0.0.0/0"]
}
resource "aws_security_group_rule" "inbound-postgres-ims-income" {
  type = "ingress"
  to_port = 5432
  from_port = 5432
  protocol = "TCP"
  security_group_id = "sg-0a73d72299314a38e"
  cidr_blocks = ["18.222.94.189/32"]
}

resource "aws_api_gateway_authorizer" "los-lambda-authorizer" {
  authorizer_credentials           = null
  authorizer_result_ttl_in_seconds = 300
  authorizer_uri                   = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/arn:aws:lambda:us-east-1:533267089472:function:los-aws-cognito-authorizer/invocations"
  identity_source                  = "method.request.header.Authorization"
  name                             = "los-lambda-authorizer"
  rest_api_id                      = aws_api_gateway_rest_api.los-voie-api.id
  type                             = "REQUEST"
}

resource "aws_cognito_user_pool" "exp-dynamic-policy-users" {
  name = "exp-dynamic-policy-users"
  schema {
    attribute_data_type = "String"
    name                = "tenant_id"
    developer_only_attribute = false
    mutable = false
    string_attribute_constraints {
      min_length = "3"
      max_length = "100"
    }
  }
}
