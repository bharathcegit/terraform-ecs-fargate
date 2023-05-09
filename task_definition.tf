resource "aws_ecs_task_definition" "demo_task_definition" {
  family                   = "demo_task"
  container_definitions    = jsonencode([{
    name            = "apache2"
    image           = "httpd:latest"
    essential       = true
    portMappings    = [{
      containerPort = 80
      hostPort      = 80
    }]
  }])
  memory          = 512
  cpu             = 256
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"

  execution_role_arn       = aws_iam_role.task_execution_role.arn
}



resource "aws_iam_role" "task_execution_role" {
  name = "task_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "task_execution_role_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  role       = aws_iam_role.task_execution_role.name
}

