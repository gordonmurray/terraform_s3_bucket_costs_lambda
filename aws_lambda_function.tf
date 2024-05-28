
# Create Lambda function
resource "aws_lambda_function" "s3_summary" {
  filename         = "lambda.zip" # Path to your Lambda deployment package
  function_name    = "s3_summary"
  role             = aws_iam_role.lambda_exec_role.arn
  handler          = "lambda_function.lambda_handler"
  source_code_hash = filebase64sha256("lambda.zip")
  runtime          = "python3.9" # Change to your desired runtime
  timeout          = 300  # Maximum execution time of 5 minutes

  environment {
    variables = {
      OUTPUT_BUCKET = var.output_bucket
    }
  }
}

# Create CloudWatch Event rule
resource "aws_cloudwatch_event_rule" "daily_run" {
  name                = "daily_run"
  schedule_expression = "cron(0 0 1 * ? *)"  # At 00:00 UTC on the 1st day of every month
}

# Create CloudWatch Event target
resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.daily_run.name
  target_id = "lambda"
  arn       = aws_lambda_function.s3_summary.arn
}

# Add permissions for CloudWatch to invoke Lambda
resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.s3_summary.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_run.arn
}
