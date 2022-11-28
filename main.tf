locals {
  zip_filename     = var.package_type == "zip" ? "${random_uuid.code_hash.result}.zip" : "${random_uuid.code_hash.result}"
  hash_files_paths = flatten(setunion([for path in var.hash_sources : fileset(var.source_dir, path)]))
  source_code_hash = base64encode(filemd5(var.output_dir))
  etag             = filemd5(var.output_dir)
}

resource "random_uuid" "code_hash" {
  keepers = {
    for filename in local.hash_files_paths : filename => filemd5("${var.source_dir}/${filename}")
  }
}

data "archive_file" "code" {
  type        = var.package_type
  source_dir  = var.source_dir
  output_path = var.output_dir
  excludes    = var.excluded_paths
}

resource "aws_s3_object" "lambda_code_object" {
  bucket      = var.deployment_bucket_id
  key         = var.deployment_bucket_prefix != "" ? "${var.deployment_bucket_prefix}/${local.zip_filename}" : local.zip_filename
  source      = var.output_dir
  etag        = local.etag
  source_hash = local.source_code_hash

  depends_on = [data.archive_file.code]
}
