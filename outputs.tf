output "s3_key" {
  value = aws_s3_object.lambda_code_object.key
}

output "output_base64sha256" {
  value = data.archive_file.code.output_base64sha256
}

output "zip_id" {
  value = random_uuid.code_hash.result
}

output "hash_files_paths" {
  value = local.hash_files_paths
}
