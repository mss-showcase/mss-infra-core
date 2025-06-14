provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "shared_data" {
  bucket = var.shared_data_bucket
  tags = {
    Name    = "mss-s3bucket-shared-data"
    Project = "mss"
  }
}

resource "aws_s3_bucket" "shared_build_data" {
  bucket = var.shared_build_data_bucket
  tags = {
    Name    = "mss-s3bucket-shared-build-data"
    Project = "mss"
  }
}

resource "aws_s3_bucket" "webhosting" {
  bucket = var.webhosting_bucket
  tags = {
    Name    = var.webhosting_bucket
    Project = "mss"
  }
}

resource "aws_s3_bucket_website_configuration" "webhosting" {
  bucket = aws_s3_bucket.webhosting.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html" 
  }
}

resource "aws_s3_bucket_public_access_block" "webhosting" {
  bucket                  = aws_s3_bucket.webhosting.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "webhosting_public_read" {
  bucket = aws_s3_bucket.webhosting.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = [
          "s3:GetObject"
        ]
        Resource = "${aws_s3_bucket.webhosting.arn}/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.webhosting]
}

output "shared_data_bucket" {
  value = aws_s3_bucket.shared_data.id
}

output "shared_build_data_bucket" {
  value = aws_s3_bucket.shared_build_data.id
}

output "webhosting_bucket" {
  value = aws_s3_bucket.webhosting.id
}

output "webhosting_website_endpoint" {
  value = aws_s3_bucket_website_configuration.webhosting.website_endpoint
}