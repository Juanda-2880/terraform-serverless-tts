data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/../src/index.py"     
  output_path = "${path.module}/lambda_function.zip"  
}

resource "aws_lambda_function" "tts_lambda" {
  function_name = "${var.resource_name}-function"

  filename         = data.archive_file.lambda_zip.output_path
  source_code_hash = data.archive_file.lambda_zip.output_base64sha256 
  handler          = "index.lambda_handler"  
  runtime          = "python3.9"            

  role = aws_iam_role.lambda_exec_role.arn

  environment {
    variables = {
      BUCKET_NAME = aws_s3_bucket.storage_bucket.id
    }
  }

  timeout     = 10  
  memory_size = 128
}