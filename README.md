# MSS Infra Core

This project provisions and manages the core AWS infrastructure resources for the MSS Showcase environment using Terraform.  
It is designed to be reusable and automated, supporting deployment via GitHub Actions.

## Features

- **S3 Buckets** for shared data, build artifacts, and static web hosting
- **DynamoDB tables** for structured data storage (optional/extendable)
- **Static website hosting** with public access configuration
- **Automated deployment** using GitHub Actions workflows

## Usage

1. **Configure variables** in `terraform.tfvars` or via environment variables.
2. **Deploy infrastructure** using Terraform:
   ```sh
   terraform init
   terraform apply