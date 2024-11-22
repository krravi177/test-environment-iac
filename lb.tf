# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

resource "aws_lb_target_group" "ecs-income-los-authentication-ap" {
  name = "ecs-income-los-authentication-ap"
  target_type = "ip"
  port = 80
  protocol = "HTTP"
  vpc_id = "vpc-081918aff61bd89e6"
}
resource "aws_lb_target_group" "ecs-audit-api-ap" {
  name = "ecs-audit-api-ap"
  target_type = "ip"
  port = 8080
  protocol = "HTTP"
  vpc_id = "vpc-081918aff61bd89e6"
}
resource "aws_lb_target_group" "ecs-income-request-ap" {
  name = "ecs-income-request-ap"
  target_type = "ip"
  port = 8080
  protocol = "HTTP"
  vpc_id = "vpc-081918aff61bd89e6"
}
resource "aws_lb_target_group" "ecs-income-response-ap" {
  name = "ecs-income-response-ap"
  target_type = "ip"
  port = 8080
  protocol = "HTTP"
  vpc_id = "vpc-081918aff61bd89e6"
}
resource "aws_lb_target_group" "ecs-income-workflow-ap" {
  name = "ecs-income-workflow-ap"
  target_type = "ip"
  port = 8080
  protocol = "HTTP"
  vpc_id = "vpc-081918aff61bd89e6"
}
resource "aws_lb_target_group" "ecs-income-rule-ap" {
  name = "ecs-income-rule-ap"
  target_type = "ip"
  port = 8080
  protocol = "HTTP"
  vpc_id = "vpc-081918aff61bd89e6"
}
resource "aws_lb_target_group" "ecs-ims-document-service-alb-tg" {
  name = "ecs-ims-document-service-alb-tg"
  target_type = "ip"
  port = 80
  protocol = "HTTP"
  vpc_id = "vpc-081918aff61bd89e6"
}

resource "aws_lb_target_group" "nlbToalbIncomeRequest" {
  name = "nlbToalbIncomeRequest"
  target_type = "alb"
  port = 8080
  protocol = "TCP"
  vpc_id = "vpc-081918aff61bd89e6"
  target_health_state {
    enable_unhealthy_connection_termination = false
  }
}
resource "aws_lb_target_group" "nlbToalbIncomeResponse" {
  name = "nlbToalbIncomeResponse"
  target_type = "alb"
  port = 8080
  protocol = "TCP"
  vpc_id = "vpc-081918aff61bd89e6"
  target_health_state {
    enable_unhealthy_connection_termination = false
  }
}
resource "aws_lb_target_group" "ims-document-service-nlb-tg" {
  name = "ims-document-service-nlb-tg"
  target_type = "alb"
  port = 8080
  protocol = "TCP"
  vpc_id = "vpc-081918aff61bd89e6"
  target_health_state {
    enable_unhealthy_connection_termination = false
  }
}
resource "aws_lb_target_group" "nlbToalbIncomeWorkflow" {
  name = "nlbToalbIncomeWorkflow"
  target_type = "alb"
  port = 8080
  protocol = "TCP"
  vpc_id = "vpc-081918aff61bd89e6"
  target_health_state {
    enable_unhealthy_connection_termination = false
  }
}
resource "aws_lb_target_group" "nlbToalbAuthenticationApp" {
  name = "nlbToalbAuthenticationApp"
  target_type = "alb"
  port = 8080
  protocol = "TCP"
  vpc_id = "vpc-081918aff61bd89e6"
  target_health_state {
    enable_unhealthy_connection_termination = false
  }
}

resource "aws_lb" "audit-api-lb" {
  name = "audit-api-lb"
  internal = true
  load_balancer_type = "application"
  security_groups = ["sg-0a73d72299314a38e"]
  subnets = ["subnet-01a1e5313541d8103", "subnet-0ed2309781dd1d3e1"]
}
resource "aws_lb_listener" "audit-api-listener" {
  load_balancer_arn = aws_lb.audit-api-lb.arn
  port = 8080
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ecs-audit-api-ap.arn
  }
}
resource "aws_lb" "los-document-service-api-alb" {
  name = "los-document-service-api-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = ["sg-0a73d72299314a38e"]
  subnets = ["subnet-01a1e5313541d8103", "subnet-0ed2309781dd1d3e1"]
}
resource "aws_lb_listener" "los-document-service-api-listener" {
  load_balancer_arn = aws_lb.los-document-service-api-alb.arn
  port = 8080
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ecs-ims-document-service-alb-tg.arn
  }
}
resource "aws_lb" "los-authentication-app-api-alb" {
  name = "los-authentication-app-api-alb"
  internal = true
  load_balancer_type = "application"
  security_groups = ["sg-0a73d72299314a38e"]
  subnets = ["subnet-01a1e5313541d8103", "subnet-0ed2309781dd1d3e1"]
}
resource "aws_lb_listener" "los-authentication-app-api-listener" {
  load_balancer_arn = aws_lb.los-authentication-app-api-alb.arn
  port = 8080
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ecs-income-los-authentication-ap.arn
  }
}
resource "aws_lb" "income-request-api-alb" {
  name = "income-request-api-alb"
  internal = true
  load_balancer_type = "application"
  security_groups = ["sg-0a73d72299314a38e"]
  subnets = ["subnet-01a1e5313541d8103", "subnet-0ed2309781dd1d3e1"]
}
resource "aws_lb_listener" "income-request-api-listener" {
  load_balancer_arn = aws_lb.income-request-api-alb.arn
  port = 8080
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ecs-income-request-ap.arn
  }
}
resource "aws_lb" "income-response-api-alb" {
  name = "income-response-api-alb"
  internal = true
  load_balancer_type = "application"
  security_groups = ["sg-0a73d72299314a38e"]
  subnets = ["subnet-01a1e5313541d8103", "subnet-0ed2309781dd1d3e1"]
}
resource "aws_lb_listener" "income-response-api-listener" {
  load_balancer_arn = aws_lb.income-response-api-alb.arn
  port = 8080
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ecs-income-response-ap.arn
  }
}
resource "aws_lb" "income-rule-api-alb" {
  name = "income-rule-api-alb"
  internal = true
  load_balancer_type = "application"
  security_groups = ["sg-0a73d72299314a38e"]
  subnets = ["subnet-01a1e5313541d8103", "subnet-0ed2309781dd1d3e1"]
}
resource "aws_lb_listener" "income-rule-api-listener" {
  load_balancer_arn = aws_lb.income-rule-api-alb.arn
  port = 8080
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ecs-income-rule-ap.arn
  }
}
resource "aws_lb" "income-workflow-api-alb" {
  name = "income-workflow-api-alb"
  internal = true
  load_balancer_type = "application"
  security_groups = ["sg-0a73d72299314a38e"]
  subnets = ["subnet-01a1e5313541d8103", "subnet-0ed2309781dd1d3e1"]
}
resource "aws_lb_listener" "income-workflow-api-listener" {
  load_balancer_arn = aws_lb.income-workflow-api-alb.arn
  port = 8080
  protocol = "HTTP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ecs-income-workflow-ap.arn
  }
}
resource "aws_lb" "ecs-ims-document-service-nlb" {
  name = "ecs-ims-document-service-nlb"
  internal = false
  load_balancer_type = "network"
  subnets = ["subnet-01a1e5313541d8103", "subnet-0ed2309781dd1d3e1"]
}
resource "aws_lb_listener" "ecs-ims-document-service-listener" {
  load_balancer_arn = aws_lb.ecs-ims-document-service-nlb.arn
  port = 8080
  protocol = "TCP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.ims-document-service-nlb-tg.arn
  }
}
resource "aws_lb" "income-request-api-nlb" {
  name = "income-request-api-nlb"
  internal = true
  load_balancer_type = "network"
  subnets = ["subnet-01a1e5313541d8103", "subnet-0ed2309781dd1d3e1"]
}
resource "aws_lb_listener" "income-request-api-nlb-listener" {
  load_balancer_arn = aws_lb.income-request-api-nlb.arn
  port = 8080
  protocol = "TCP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nlbToalbIncomeRequest.arn
  }
}
resource "aws_lb" "income-response-api-nlb" {
  name = "income-response-api-nlb"
  internal = true
  load_balancer_type = "network"
  subnets = ["subnet-01a1e5313541d8103", "subnet-0ed2309781dd1d3e1"]
}
resource "aws_lb_listener" "income-response-api-nlb-listener" {
  load_balancer_arn = aws_lb.income-response-api-nlb.arn
  port = 8080
  protocol = "TCP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nlbToalbIncomeResponse.arn
  }
}
resource "aws_lb" "income-workflow-api-nlb" {
  name = "income-workflow-api-nlb"
  internal = true
  load_balancer_type = "network"
  subnets = ["subnet-01a1e5313541d8103", "subnet-0ed2309781dd1d3e1"]
}
resource "aws_lb_listener" "income-workflow-api-nlb-listener" {
  load_balancer_arn = aws_lb.income-workflow-api-nlb.arn
  port = 8080
  protocol = "TCP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nlbToalbIncomeWorkflow.arn
  }
}

resource "aws_lb" "ims-authentication-api-nlb" {
  name = "ims-authentication-api-nlb"
  internal = true
  load_balancer_type = "network"
  security_groups = ["sg-0a73d72299314a38e"]
  subnets = ["subnet-01a1e5313541d8103", "subnet-0ed2309781dd1d3e1"]
}
resource "aws_lb_listener" "ims-authentication-api-listener" {
  load_balancer_arn = aws_lb.ims-authentication-api-nlb.arn
  port = 8080
  protocol = "TCP"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.nlbToalbAuthenticationApp.arn
  }
}
