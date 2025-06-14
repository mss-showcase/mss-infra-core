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

resource "aws_s3_bucket_policy" "shared_data_public_read" {
  bucket = aws_s3_bucket.shared_data.id

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
        Resource = "${aws_s3_bucket.shared_data.arn}/*"
      }
    ]
  })
}

resource "aws_s3_bucket_website_configuration" "shared_data_website" {
  bucket = aws_s3_bucket.shared_data.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

output "shared_data_bucket" {
  value = aws_s3_bucket.shared_data.id
}

output "shared_build_data_bucket" {
  value = aws_s3_bucket.shared_build_data.id
}