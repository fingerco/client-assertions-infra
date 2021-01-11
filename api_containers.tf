resource "aws_ecr_repository" "client-assertions-api" {
  name                 = "client-assertions-api"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecs_cluster" "client-assertions-api" {
  name = "client-assertions-api"
  capacity_providers = ["FARGATE"]
}

resource "aws_ecs_task_definition" "client-assertions-api" {
  family                    = "client-assertions-api"
  container_definitions     = file("task-definitions/api-service.json")
  network_mode              = "awsvpc"
  task_role_arn             = aws_iam_role.client-assertions-api.arn
  execution_role_arn        = data.aws_iam_role.ecs_task_execution_role.arn
  requires_compatibilities  = ["FARGATE"]
  cpu                       = 256
  memory                    = 512
}

resource "aws_ecs_service" "client-assertions-api" {
  name                  = "client-assertions-api"
  cluster               = aws_ecs_cluster.client-assertions-api.id
  task_definition       = aws_ecs_task_definition.client-assertions-api.arn
  desired_count         = 3
  launch_type           = "FARGATE"
  force_new_deployment  = true

  network_configuration {
    subnets           = [aws_subnet.public-west-2a.id, aws_subnet.public-west-2b.id]
    assign_public_ip  = true
    security_groups   = [aws_security_group.client-assertions-api-svc.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.client-assertions-api.arn
    container_name   = "api"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.client-assertions-api]
}
