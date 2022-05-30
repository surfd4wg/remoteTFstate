resource "aws_s3_bucket" "main" {
  bucket = "${var.client}-tf-state"
  acl    = "private"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = "${var.client}-tf-state"
    description = "${var.client} s3 bucket for Terraform state management"
  }
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket                  = aws_s3_bucket.main.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "main" {
  name           = "${var.client}-tf-state"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name        = "${var.client}-tf-state"
    description = "${var.client} dynamodb table for Terraform lock management"
  }
}

resource "aws_iam_role" "main" {
  name = "${var.client}-tf-state"

  assume_role_policy = jsonencode(
    {
      "Version" = "2012-10-17",
      "Statement" = [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Service" : "codebuild.amazonaws.com"
          },
          "Action" : "sts:AssumeRole"
        }
      ]
  })

  tags = {
    Name        = "${var.client}-tf-state"
    description = "${var.client} Iam role for using the terraform backend"
  }
}

resource "aws_iam_role_policy" "main" {
  name = "${var.client}-tf-state"
  role = aws_iam_role.main.name

  policy = jsonencode({
    "Version" = "2012-10-17",
    "Statement" = [
      {
        "Effect"   = "Allow",
        "Action"   = "s3:ListBucket",
        "Resource" = "${aws_s3_bucket.main.arn}"
      },
      {
        "Effect"   = "Allow",
        "Action"   = ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
        "Resource" = "${aws_s3_bucket.main.arn}/*"
      },
      {
        "Effect" = "Allow",
        "Action" = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:DeleteItem"
        ],
        "Resource" = "arn:aws:dynamodb:*:*:table/${aws_dynamodb_table.main.name}"
      }
    ]
  })
}