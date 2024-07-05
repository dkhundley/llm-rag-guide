variable resource_prefix {
    description = "Prefix to set on all created resources"
}

variable bedrock_embedding_model_arn {
    description = "The ARN associated to the embedding model to be used within Bedrock"
}

variable doc_source_bucket_arn {
    description = "The ARN associated to the S3 bucket that contains the documents to be ingested into Bedrock KB"
}