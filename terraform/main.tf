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

output "shared_data_bucket" {
  value = aws_s3_bucket.shared_data.id
}

output "shared_build_data_bucket" {
  value = aws_s3_bucket.shared_build_data.id
}

output "webhosting_bucket" {
  value = aws_s3_bucket.webhosting.id
}