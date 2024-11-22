# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.
        
# __generated__ by Terraform from "https://sqs.us-east-1.amazonaws.com/533267089472/audit-queue.fifo"
resource "aws_sqs_queue" "audit-queue" {
  content_based_deduplication       = true
  deduplication_scope               = "messageGroup"
  delay_seconds                     = 0
  fifo_queue                        = true
  fifo_throughput_limit             = "perMessageGroupId"
  kms_data_key_reuse_period_seconds = 300
  kms_master_key_id                 = null
  max_message_size                  = 262144
  message_retention_seconds         = 345600
  name                              = "audit-queue.fifo"
  name_prefix                       = null
  policy = jsonencode({
    Id = "__default_policy_ID"
    Statement = [{
      Action = "SQS:*"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::533267089472:root"
      }
      Resource = "arn:aws:sqs:us-east-1:533267089472:audit-queue.fifo"
      Sid      = "__owner_statement"
    }]
    Version = "2012-10-17"
  })
  receive_wait_time_seconds = 0
  redrive_allow_policy      = null
  redrive_policy = jsonencode({
    deadLetterTargetArn = "arn:aws:sqs:us-east-1:533267089472:audit-dlq-queue.fifo"
    maxReceiveCount     = 4
  })
  sqs_managed_sse_enabled    = true
  tags                       = {}
  tags_all                   = {}
  visibility_timeout_seconds = 30
}

# __generated__ by Terraform from "https://sqs.us-east-1.amazonaws.com/533267089472/q-response-eval-dql"
resource "aws_sqs_queue" "q-response-eval-dql" {
  content_based_deduplication       = false
  deduplication_scope               = null
  delay_seconds                     = 0
  fifo_queue                        = false
  fifo_throughput_limit             = null
  kms_data_key_reuse_period_seconds = 300
  kms_master_key_id                 = null
  max_message_size                  = 262144
  message_retention_seconds         = 345600
  name                              = "q-response-eval-dql"
  name_prefix                       = null
  policy = jsonencode({
    Id = "__default_policy_ID"
    Statement = [{
      Action = "SQS:*"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::533267089472:root"
      }
      Resource = "arn:aws:sqs:us-east-1:533267089472:q-response-eval-dql"
      Sid      = "__owner_statement"
    }]
    Version = "2012-10-17"
  })
  receive_wait_time_seconds  = 0
  redrive_allow_policy       = null
  redrive_policy             = null
  sqs_managed_sse_enabled    = true
  tags                       = {}
  tags_all                   = {}
  visibility_timeout_seconds = 30
}

# __generated__ by Terraform from "https://sqs.us-east-1.amazonaws.com/533267089472/q-response-eval"
resource "aws_sqs_queue" "q-response-eval" {
  content_based_deduplication       = false
  deduplication_scope               = null
  delay_seconds                     = 0
  fifo_queue                        = false
  fifo_throughput_limit             = null
  kms_data_key_reuse_period_seconds = 300
  kms_master_key_id                 = null
  max_message_size                  = 262144
  message_retention_seconds         = 345600
  name                              = "q-response-eval"
  name_prefix                       = null
  policy = jsonencode({
    Id = "__default_policy_ID"
    Statement = [{
      Action = "SQS:*"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::533267089472:root"
      }
      Resource = "arn:aws:sqs:us-east-1:533267089472:q-response-eval"
      Sid      = "__owner_statement"
    }]
    Version = "2012-10-17"
  })
  receive_wait_time_seconds = 0
  redrive_allow_policy      = null
  redrive_policy = jsonencode({
    deadLetterTargetArn = "arn:aws:sqs:us-east-1:533267089472:q-response-eval-dql"
    maxReceiveCount     = 10
  })
  sqs_managed_sse_enabled    = true
  tags                       = {}
  tags_all                   = {}
  visibility_timeout_seconds = 30
}

# __generated__ by Terraform from "https://sqs.us-east-1.amazonaws.com/533267089472/income-request-podium-request-dlq"
resource "aws_sqs_queue" "income-request-podium-request-dlq" {
  content_based_deduplication       = false
  deduplication_scope               = null
  delay_seconds                     = 0
  fifo_queue                        = false
  fifo_throughput_limit             = null
  kms_data_key_reuse_period_seconds = 300
  kms_master_key_id                 = null
  max_message_size                  = 262144
  message_retention_seconds         = 1209600
  name                              = "income-request-podium-request-dlq"
  name_prefix                       = null
  policy = jsonencode({
    Id = "__default_policy_ID"
    Statement = [{
      Action = "SQS:*"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::533267089472:root"
      }
      Resource = "arn:aws:sqs:us-east-1:533267089472:income-request-podium-request-dlq"
      Sid      = "__owner_statement"
      }, {
      Action = "SQS:SendMessage"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::533267089472:root"
      }
      Resource = "arn:aws:sqs:us-east-1:533267089472:income-request-podium-request-dlq"
      Sid      = "__sender_statement"
      }, {
      Action = ["SQS:ChangeMessageVisibility", "SQS:DeleteMessage", "SQS:ReceiveMessage"]
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::533267089472:root"
      }
      Resource = "arn:aws:sqs:us-east-1:533267089472:income-request-podium-request-dlq"
      Sid      = "__receiver_statement"
      }, {
      Action = "SQS:SendMessage"
      Condition = {
        ArnLike = {
          "aws:SourceArn" = "arn:aws:sns:us-east-1:533267089472:income-request-received"
        }
      }
      Effect = "Allow"
      Principal = {
        AWS = "*"
      }
      Resource = "arn:aws:sqs:us-east-1:533267089472:income-request-podium-request-dlq"
      Sid      = "topic-subscription-arn:arn:aws:sns:us-east-1:533267089472:income-request-received"
    }]
    Version = "2012-10-17"
  })
  receive_wait_time_seconds = 0
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue"
    sourceQueueArns   = ["arn:aws:sqs:us-east-1:533267089472:income-request-podium-request"]
  })
  redrive_policy             = null
  sqs_managed_sse_enabled    = true
  tags                       = {}
  tags_all                   = {}
  visibility_timeout_seconds = 30
}

# __generated__ by Terraform from "https://sqs.us-east-1.amazonaws.com/533267089472/audit-dlq-queue.fifo"
resource "aws_sqs_queue" "audit-dlq-queue" {
  content_based_deduplication       = true
  deduplication_scope               = "messageGroup"
  delay_seconds                     = 0
  fifo_queue                        = true
  fifo_throughput_limit             = "perMessageGroupId"
  kms_data_key_reuse_period_seconds = 300
  kms_master_key_id                 = null
  max_message_size                  = 262144
  message_retention_seconds         = 345600
  name                              = "audit-dlq-queue.fifo"
  name_prefix                       = null
  policy = jsonencode({
    Id = "__default_policy_ID"
    Statement = [{
      Action = "SQS:*"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::533267089472:root"
      }
      Resource = "arn:aws:sqs:us-east-1:533267089472:audit-dlq-queue.fifo"
      Sid      = "__owner_statement"
    }]
    Version = "2012-10-17"
  })
  receive_wait_time_seconds = 0
  redrive_allow_policy = jsonencode({
    redrivePermission = "byQueue"
    sourceQueueArns   = ["arn:aws:sqs:us-east-1:533267089472:audit-queue.fifo"]
  })
  redrive_policy             = null
  sqs_managed_sse_enabled    = true
  tags                       = {}
  tags_all                   = {}
  visibility_timeout_seconds = 30
}


# __generated__ by Terraform from "https://sqs.us-east-1.amazonaws.com/533267089472/income-request-podium-request"
resource "aws_sqs_queue" "income-request-podium-request" {
  content_based_deduplication       = false
  deduplication_scope               = null
  delay_seconds                     = 0
  fifo_queue                        = false
  fifo_throughput_limit             = null
  kms_data_key_reuse_period_seconds = 300
  kms_master_key_id                 = null
  max_message_size                  = 262144
  message_retention_seconds         = 345600
  name                              = "income-request-podium-request"
  name_prefix                       = null
  policy = jsonencode({
    Id = "__default_policy_ID"
    Statement = [{
      Action = "SQS:*"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::533267089472:root"
      }
      Resource = "arn:aws:sqs:us-east-1:533267089472:income-request-podium-request"
      Sid      = "__owner_statement"
      }, {
      Action = "SQS:SendMessage"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::533267089472:root"
      }
      Resource = "arn:aws:sqs:us-east-1:533267089472:income-request-podium-request"
      Sid      = "__sender_statement"
      }, {
      Action = ["SQS:ChangeMessageVisibility", "SQS:DeleteMessage", "SQS:ReceiveMessage"]
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::533267089472:root"
      }
      Resource = "arn:aws:sqs:us-east-1:533267089472:income-request-podium-request"
      Sid      = "__receiver_statement"
      }, {
      Action = "SQS:SendMessage"
      Condition = {
        ArnLike = {
          "aws:SourceArn" = "arn:aws:sns:us-east-1:533267089472:income-request-received"
        }
      }
      Effect = "Allow"
      Principal = {
        AWS = "*"
      }
      Resource = "arn:aws:sqs:us-east-1:533267089472:income-request-podium-request"
      Sid      = "topic-subscription-arn:arn:aws:sns:us-east-1:533267089472:income-request-received"
    }]
    Version = "2012-10-17"
  })
  receive_wait_time_seconds = 0
  redrive_allow_policy      = null
  redrive_policy = jsonencode({
    deadLetterTargetArn = "arn:aws:sqs:us-east-1:533267089472:income-request-podium-request-dlq"
    maxReceiveCount     = 3
  })
  sqs_managed_sse_enabled    = true
  tags                       = {}
  tags_all                   = {}
  visibility_timeout_seconds = 30
}

# __generated__ by Terraform from "FileResourceMappings"
resource "aws_dynamodb_table" "FileResourceMappings" {
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  hash_key                    = "id"
  name                        = "FileResourceMappings"
  range_key                   = "tenantId"
  read_capacity               = 5
  restore_date_time           = null
  restore_source_name         = null
  restore_source_table_arn    = null
  restore_to_latest_time      = null
  stream_enabled              = false
  stream_view_type            = null
  table_class                 = "STANDARD"
  tags                        = {}
  tags_all                    = {}
  write_capacity              = 5
  attribute {
    name = "id"
    type = "S"
  }
  attribute {
    name = "tenantId"
    type = "S"
  }
  point_in_time_recovery {
    enabled = false
  }
  ttl {
    attribute_name = null
    enabled        = false
  }
}

# __generated__ by Terraform from "AuditRecords"
resource "aws_dynamodb_table" "auditrecords" {
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  hash_key                    = "id"
  name                        = "AuditRecords"
  range_key                   = null
  read_capacity               = 5
  restore_date_time           = null
  restore_source_name         = null
  restore_source_table_arn    = null
  restore_to_latest_time      = null
  stream_enabled              = false
  stream_view_type            = null
  table_class                 = "STANDARD"
  tags                        = {}
  tags_all                    = {}
  write_capacity              = 5
  attribute {
    name = "id"
    type = "S"
  }
  point_in_time_recovery {
    enabled = false
  }
  ttl {
    attribute_name = null
    enabled        = false
  }
}

# __generated__ by Terraform from "drool-rules"
resource "aws_dynamodb_table" "drool-rules" {
  billing_mode                = "PROVISIONED"
  deletion_protection_enabled = false
  hash_key                    = "tenantId"
  name                        = "drool-rules"
  range_key                   = null
  read_capacity               = 5
  restore_date_time           = null
  restore_source_name         = null
  restore_source_table_arn    = null
  restore_to_latest_time      = null
  stream_enabled              = false
  stream_view_type            = null
  table_class                 = "STANDARD"
  tags                        = {}
  tags_all                    = {}
  write_capacity              = 5
  attribute {
    name = "tenantId"
    type = "S"
  }
  point_in_time_recovery {
    enabled = false
  }
  ttl {
    attribute_name = null
    enabled        = false
  }
}

# __generated__ by Terraform from "vendor-pdfs-bucket"
resource "aws_s3_bucket" "vendor-pdfs-bucket" {
  bucket              = "test-533267089472.vendor-pdfs-bucket"
  bucket_prefix       = null
  force_destroy       = null
  object_lock_enabled = false
  tags                = {}
  tags_all            = {}
}

# __generated__ by Terraform from "los-voie-request"
resource "aws_s3_bucket" "los-voie-request" {
  bucket              = "test-533267089472.los-voie-request"
  bucket_prefix       = null
  force_destroy       = null
  object_lock_enabled = false
  tags                = {}
  tags_all            = {}
}

