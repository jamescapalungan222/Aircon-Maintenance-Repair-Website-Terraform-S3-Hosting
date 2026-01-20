provider "aws" {
    region = var.region
    profile = var.aws_profile
}


resource "aws_s3_bucket" "website" {
    bucket = var.bucket_name
    force_destroy = true

    tags = {
        Name = var.project_name
    }
}

resource "aws_s3_bucket_website_configuration" "website" {
    bucket = aws_s3_bucket.website.id

    index_document {
        suffix = "index.html"
    }

    error_document {
        key = "error.html"
    }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
    bucket                  = aws_s3_bucket.website.id
    block_public_acls       = false
    block_public_policy     = false
    ignore_public_acls      = false
    restrict_public_buckets = false
}


resource "aws_s3_bucket_policy" "public_read" {
bucket = aws_s3_bucket.website.id

policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website.arn}/*"
    }]
    })
}

resource "aws_s3_object" "files" {
    for_each = fileset("${path.module}/../website", "**")

    bucket = aws_s3_bucket.website.id
    key    = each.value
    source = "${path.module}/../website/${each.value}"

content_type = lookup({
    html = "text/html"
    css  = "text/css"
    js   = "application/javascript"
    png  = "image/png"
    jpg  = "image/jpeg"
    jpeg = "image/jpeg"
    
    }, split(".", each.value)[length(split(".", each.value)) - 1], "application/octet-stream")
}







