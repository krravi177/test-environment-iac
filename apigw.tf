########################################
# VPC links
########################################
resource "aws_api_gateway_vpc_link" "rest-voie-income-request-link" {
  name = "rest-voie-income-request-link"
  target_arns = [aws_lb.income-request-api-nlb.arn]
}
resource "aws_api_gateway_vpc_link" "rest-voie-response-link" {
  name = "rest-voie-response-link"
  target_arns = [aws_lb.income-response-api-nlb.arn]
}
resource "aws_api_gateway_vpc_link" "rest-ims-document-service-link" {
  name = "rest-ims-document-service-link"
  target_arns = [aws_lb.ecs-ims-document-service-nlb.arn]
}
resource "aws_api_gateway_vpc_link" "rest-voie-income-workflow-link" {
  name = "rest-voie-income-workflow-link"
  target_arns = [aws_lb.income-workflow-api-nlb.arn]
}
resource "aws_api_gateway_vpc_link" "rest-voie-authentication-link" {
  name = "rest-voie-authentication-link"
  target_arns = [aws_lb.ims-authentication-api-nlb.arn]
}


########################################
# LOS VOIE rest api
########################################
resource "aws_api_gateway_rest_api" "los-voie-api" {
  name = "los-voie-api"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "income-order-request" {
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  path_part = "income-order-request"
  parent_id = aws_api_gateway_rest_api.los-voie-api.root_resource_id
}

resource "aws_api_gateway_method" "income-order-request-post" {
  http_method = "POST"
  authorization = "NONE"
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  resource_id = aws_api_gateway_resource.income-order-request.id
}

resource "aws_api_gateway_integration" "income-order-request-vpc-link" {
  http_method = aws_api_gateway_method.income-order-request-post.http_method
  integration_http_method = aws_api_gateway_method.income-order-request-post.http_method
  resource_id = aws_api_gateway_resource.income-order-request.id
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  type        = "HTTP"
  connection_type = "VPC_LINK"
  connection_id = aws_api_gateway_vpc_link.rest-voie-income-request-link.id
  uri = "http://${aws_lb.income-request-api-alb.dns_name}:${aws_lb_listener.income-request-api-listener.port}/income-request/requests"
}

resource "aws_api_gateway_resource" "income-order-response" {
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  path_part = "income-order-response"
  parent_id = aws_api_gateway_rest_api.los-voie-api.root_resource_id
}

resource "aws_api_gateway_method" "income-order-response-post" {
  http_method = "POST"
  authorization = "NONE"
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  resource_id = aws_api_gateway_resource.income-order-response.id
}

resource "aws_api_gateway_integration" "income-order-response-vpc-link" {
  http_method = aws_api_gateway_method.income-order-response-post.http_method
  integration_http_method = aws_api_gateway_method.income-order-response-post.http_method
  resource_id = aws_api_gateway_resource.income-order-response.id
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  type        = "HTTP"
  connection_type = "VPC_LINK"
  connection_id = aws_api_gateway_vpc_link.rest-voie-response-link.id
  uri = "http://${aws_lb.income-response-api-alb.dns_name}:${aws_lb_listener.income-response-api-listener.port}/income-response/responses"
}

resource "aws_api_gateway_resource" "income-workflow-api" {
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  path_part = "income-workflow-api"
  parent_id = aws_api_gateway_rest_api.los-voie-api.root_resource_id
}
resource "aws_api_gateway_resource" "income-workflow-api-crr" {
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  path_part = "crr"
  parent_id = aws_api_gateway_resource.income-workflow-api.id
}
resource "aws_api_gateway_method" "income-workflow-api-crr-post" {
  http_method = "POST"
  authorization = "NONE"
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  resource_id = aws_api_gateway_resource.income-workflow-api-crr.id
}
resource "aws_api_gateway_integration" "income-workflow-api-vpc-link" {
  http_method = aws_api_gateway_method.income-workflow-api-crr-post.http_method
  integration_http_method = aws_api_gateway_method.income-workflow-api-crr-post.http_method
  resource_id = aws_api_gateway_resource.income-workflow-api-crr.id
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  type        = "HTTP"
  connection_type = "VPC_LINK"
  connection_id = aws_api_gateway_vpc_link.rest-voie-income-workflow-link.id
  uri = "http://${aws_lb.income-workflow-api-alb.dns_name}:${aws_lb_listener.income-workflow-api-listener.port}/income-workflow/crr"
}

resource "aws_api_gateway_resource" "income-workflow-api-crr-id" {
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  path_part = "{crr}"
  parent_id = aws_api_gateway_resource.income-workflow-api-crr.id
}
resource "aws_api_gateway_method" "income-workflow-api-crr-id-get" {
  http_method = "GET"
  authorization = "NONE"
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  resource_id = aws_api_gateway_resource.income-workflow-api-crr-id.id
}
resource "aws_api_gateway_integration" "income-workflow-api-crr-id-get-vpc-link" {
  http_method = aws_api_gateway_method.income-workflow-api-crr-id-get.http_method
  integration_http_method = aws_api_gateway_method.income-workflow-api-crr-id-get.http_method
  resource_id = aws_api_gateway_resource.income-workflow-api-crr-id.id
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  type        = "HTTP"
  connection_type = "VPC_LINK"
  connection_id = aws_api_gateway_vpc_link.rest-voie-income-workflow-link.id
  uri = "http://${aws_lb.income-workflow-api-alb.dns_name}:${aws_lb_listener.income-workflow-api-listener.port}/income-workflow/crr/{crr}"
}

resource "aws_api_gateway_resource" "income-workflow-api-requests" {
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  path_part = "requests"
  parent_id = aws_api_gateway_resource.income-workflow-api.id
}
resource "aws_api_gateway_method" "income-workflow-api-requests-post" {
  http_method = "POST"
  authorization = "NONE"
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  resource_id = aws_api_gateway_resource.income-workflow-api-requests.id
}
resource "aws_api_gateway_integration" "income-workflow-api-requests-post-vpc-link" {
  http_method = aws_api_gateway_method.income-workflow-api-requests-post.http_method
  integration_http_method = aws_api_gateway_method.income-workflow-api-requests-post.http_method
  resource_id = aws_api_gateway_resource.income-workflow-api-requests.id
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  type        = "HTTP"
  connection_type = "VPC_LINK"
  connection_id = aws_api_gateway_vpc_link.rest-voie-income-workflow-link.id
  uri = "http://${aws_lb.income-workflow-api-alb.dns_name}:${aws_lb_listener.income-workflow-api-listener.port}/income-workflow/requests"
}

resource "aws_api_gateway_resource" "income-workflow-api-requests-id" {
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  path_part = "{lmsId}"
  parent_id = aws_api_gateway_resource.income-workflow-api-requests.id
}
resource "aws_api_gateway_method" "income-workflow-api-requests-id-get" {
  http_method = "GET"
  authorization = "NONE"
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  resource_id = aws_api_gateway_resource.income-workflow-api-requests-id.id
}
resource "aws_api_gateway_integration" "income-workflow-api-requests-get-vpc-link" {
  http_method = aws_api_gateway_method.income-workflow-api-requests-id-get.http_method
  integration_http_method = aws_api_gateway_method.income-workflow-api-requests-id-get.http_method
  resource_id = aws_api_gateway_resource.income-workflow-api-requests-id.id
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  type        = "HTTP"
  connection_type = "VPC_LINK"
  connection_id = aws_api_gateway_vpc_link.rest-voie-income-workflow-link.id
  uri = "http://${aws_lb.income-workflow-api-alb.dns_name}:${aws_lb_listener.income-workflow-api-listener.port}/income-workflow/requests/{lmsId}"
}

resource "aws_api_gateway_resource" "income-workflow-api-resources" {
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  path_part = "resources"
  parent_id = aws_api_gateway_resource.income-workflow-api.id
}
resource "aws_api_gateway_method" "income-workflow-api-resources-post" {
  http_method = "POST"
  authorization = "NONE"
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  resource_id = aws_api_gateway_resource.income-workflow-api-resources.id
}
resource "aws_api_gateway_integration" "income-workflow-api-resources-post-vpc-link" {
  http_method = aws_api_gateway_method.income-workflow-api-resources-post.http_method
  integration_http_method = aws_api_gateway_method.income-workflow-api-resources-post.http_method
  resource_id = aws_api_gateway_resource.income-workflow-api-resources.id
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  type        = "HTTP"
  connection_type = "VPC_LINK"
  connection_id = aws_api_gateway_vpc_link.rest-voie-income-workflow-link.id
  uri = "http://${aws_lb.income-workflow-api-alb.dns_name}:${aws_lb_listener.income-workflow-api-listener.port}/income-workflow/resources"
}

resource "aws_api_gateway_resource" "income-workflow-api-responses" {
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  path_part = "responses"
  parent_id = aws_api_gateway_resource.income-workflow-api.id
}
resource "aws_api_gateway_method" "income-workflow-api-responses-post" {
  http_method = "POST"
  authorization = "NONE"
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  resource_id = aws_api_gateway_resource.income-workflow-api-responses.id
}
resource "aws_api_gateway_integration" "income-workflow-api-responses-post-vpc-link" {
  http_method = aws_api_gateway_method.income-workflow-api-responses-post.http_method
  integration_http_method = aws_api_gateway_method.income-workflow-api-responses-post.http_method
  resource_id = aws_api_gateway_resource.income-workflow-api-responses.id
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  type        = "HTTP"
  connection_type = "VPC_LINK"
  connection_id = aws_api_gateway_vpc_link.rest-voie-income-workflow-link.id
  uri = "http://${aws_lb.income-workflow-api-alb.dns_name}:${aws_lb_listener.income-workflow-api-listener.port}/income-workflow/responses"
}

resource "aws_api_gateway_resource" "income-workflow-api-responses-id" {
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  path_part = "{lmsId}"
  parent_id = aws_api_gateway_resource.income-workflow-api-responses.id
}
resource "aws_api_gateway_method" "income-workflow-api-responses-id-get" {
  http_method = "GET"
  authorization = "NONE"
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  resource_id = aws_api_gateway_resource.income-workflow-api-responses-id.id
}
resource "aws_api_gateway_integration" "income-workflow-api-responses-get-vpc-link" {
  http_method = aws_api_gateway_method.income-workflow-api-responses-id-get.http_method
  integration_http_method = aws_api_gateway_method.income-workflow-api-responses-id-get.http_method
  resource_id = aws_api_gateway_resource.income-workflow-api-responses-id.id
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  type        = "HTTP"
  connection_type = "VPC_LINK"
  connection_id = aws_api_gateway_vpc_link.rest-voie-income-workflow-link.id
  uri = "http://${aws_lb.income-workflow-api-alb.dns_name}:${aws_lb_listener.income-workflow-api-listener.port}/income-workflow/responses/{lmsId}"
}

########################################
# Authentication route
########################################
resource "aws_api_gateway_resource" "get-authentication-token" {
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  path_part = "get-authentication-token"
  parent_id = aws_api_gateway_rest_api.los-voie-api.root_resource_id
}
resource "aws_api_gateway_method" "get-authentication-token-post" {
  http_method = "POST"
  authorization = "NONE"
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  resource_id = aws_api_gateway_resource.get-authentication-token.id
}
resource "aws_api_gateway_integration" "get-authentication-token-post-vpc-link" {
  http_method = aws_api_gateway_method.get-authentication-token-post.http_method
  integration_http_method = aws_api_gateway_method.get-authentication-token-post.http_method
  resource_id = aws_api_gateway_resource.get-authentication-token.id
  rest_api_id = aws_api_gateway_rest_api.los-voie-api.id
  type        = "HTTP"
  connection_type = "VPC_LINK"
  connection_id = aws_api_gateway_vpc_link.rest-voie-authentication-link.id
  uri = "http://${aws_lb.ims-authentication-api-nlb.dns_name}:${aws_lb_listener.ims-authentication-api-listener.port}/los-auth/gettoken"
  
}
