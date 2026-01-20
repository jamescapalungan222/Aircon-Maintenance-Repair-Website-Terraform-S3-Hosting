output "website_url" {
    description = "S3 static website URL"
    value       = aws_s3_bucket.website.website_endpoint
}
