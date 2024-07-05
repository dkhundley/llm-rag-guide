## RESOURCE BLOCKS
## --------------------------------------------------------------------------------------------------------------
# Creating the Bedrock Knowledge Base
resource "aws_bedrockagent_knowledge_base" "bedrock_kb" {
  name     = "${local.prefix}"
  role_arn = aws_iam_role.bedrock_kb_iam_role.arn

  knowledge_base_configuration {
    vector_knowledge_base_configuration {
      embedding_model_arn = var.bedrock_embedding_model_arn
    }
    type = "VECTOR"
  }

  storage_configuration {
    type = "OPENSEARCH_SERVERLESS"
    opensearch_serverless_configuration {
      collection_arn    = aws_opensearchserverless_collection.oss_collection.arn
      vector_index_name = "bedrock-knowledge-base-default-index"
      field_mapping {
        vector_field   = "bedrock-knowledge-base-default-vector"
        text_field     = "AMAZON_BEDROCK_TEXT_CHUNK"
        metadata_field = "AMAZON_BEDROCK_METADATA"
      }
    }
  }

  depends_on = [aws_opensearchserverless_collection.oss_collection]
}



# Connecting the Bedrock Knowledge Base to the S3 bucket with the source documents
resource "aws_bedrockagent_data_source" "bedrock_kb_data_source" {
  name              = "${local.prefix}-data-source"
  knowledge_base_id = aws_bedrockagent_knowledge_base.bedrock_kb.id

  data_source_configuration {
    type = "S3"

    s3_configuration {
      bucket_arn = var.doc_source_bucket_arn
    }
  }

  depends_on = [aws_bedrockagent_knowledge_base.bedrock_kb]
}