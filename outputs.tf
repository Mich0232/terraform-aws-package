output "key" {
  value = aws_s3_object.lambda_code_object.key
}

output "output_base64sha256" {
  value = data.archive_file.code.output_base64sha256
}

output "etag" {
  value = local.etag
}

output "zip_id" {
  value = random_uuid.code_hash.result
}
