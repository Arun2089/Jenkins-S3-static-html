resource "aws_s3_bucket" "website_bucket" {
  bucket = "jenkins-s3-bucket-for-index-html-testing-9414421276931"
}

resource "aws_s3_bucket_public_access_block" "publicallow" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "website_bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  depends_on = [aws_s3_bucket_public_access_block.publicallow]
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "PublicReadGetObject"
        Effect = "Allow"
        Principal = "*"
        Action = "s3:GetObject"
        Resource = "${aws_s3_bucket.website_bucket.arn}/*"
      },
    ]
  })
}

resource "aws_s3_object" "index" {
  bucket        = aws_s3_bucket.website_bucket.bucket
  key           = "index.html"
  source        = "./index.html"
  content_type  = "text/html"
}


resource "aws_s3_bucket_website_configuration" "web-host-config" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }
}

output "s3_url" {
  description = "s3 obj url"
  value       = aws_s3_bucket_website_configuration.web-host-config.website_endpoint
}
