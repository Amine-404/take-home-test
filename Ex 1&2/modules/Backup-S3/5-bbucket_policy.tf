resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.main.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = concat([
      {
        Sid       = "EnforceSecureTransport"
        Effect    = "Deny"
        Principal = "*"
        Action = [
          "s3:*"
        ]
        Resource = [
          aws_s3_bucket.main.arn,
          "${aws_s3_bucket.main.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      }
      ],
      length(var.uploader_role_arns) > 0 ?
      [
        {
          Sid    = "AllowUploaderRole"
          Effect = "Allow"
          Principal = {
            AWS = var.uploader_role_arns
          }
          Action = [
            "s3:PutObject",
            "s3:AbortMultipartUpload",
            "s3:ListMultipartUploadParts",
          ]
          Resource = "${aws_s3_bucket.main.arn}/*"
        }
      ] : []
    )
  })

  depends_on = [aws_s3_bucket.main]
}