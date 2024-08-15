resource "aws_api_gateway_resource" "this" {
  rest_api_id = var.rest_api_id
  parent_id   = var.parent_id
  path_part   = "cp/{proxy+}"
}

resource "aws_api_gateway_method" "root_method" {
  rest_api_id   = var.rest_api_id
  resource_id   = aws_api_gateway_resource.this.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = var.authorizer_id

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_vpc_link" "this" {
  name        = "vpc-link"
  description = "VPC Link for API Gateway"
  target_arns = [var.nlb_arn]
  tags        = var.tags
}

resource "aws_api_gateway_integration" "proxy" {
  rest_api_id = var.rest_api_id
  resource_id = aws_api_gateway_resource.this.id
  http_method = aws_api_gateway_method.root_method.http_method

  type                    = "HTTP_PROXY"
  integration_http_method = "ANY"
  uri                     = "http://${var.nlb_dns_name}/{proxy}"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.this.id
  timeout_milliseconds    = 29000

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}
