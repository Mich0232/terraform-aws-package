output "key" {
  value = aws_s3_object.lambda_code_object.key
}

output "b64_hash" {
  value = local.source_code_hash
}

output "etag" {
  value = local.etag
}

output "zip_id" {
  value = random_uuid.code_hash.result
}
