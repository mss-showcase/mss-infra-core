provider "aws" {
  region = var.aws_region
}

resource "aws_s3_bucket" "shared_build_data" {
  bucket = var.shared_build_data_bucket
  tags = {
    Name    = "mss-s3bucket-shared-build-data"
    Project = "mss"
  }
}

output "shared_build_data_bucket" {
  value = aws_s3_bucket.shared_build_data.id
}