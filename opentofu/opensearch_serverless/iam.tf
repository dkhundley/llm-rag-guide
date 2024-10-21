## RESOURCE BLOCKS
## --------------------------------------------------------------------------------------------------------------
# Creating an encryption security policy
resource "aws_opensearchserverless_security_policy" "encryption_policy" {
    name = "${var.resource_prefix}-encryption-policy"
    type = "encryption"
    description = "Policy for encryption at rest for ${local.collection_name} OpenSearch Serverless collection"
    policy = jsonencode({
        Rules = [
            {
                Resource = [
                    "${local.collection_name}/*"
                ]
                ResourceType = "collection"
            }
        ],
        AWSOwnedKey = true
    })
}



# Creating a network security policy
resource "aws_opensearchserverless_security_policy" "network_security_policy" {
    name = "${var.resource_prefix}-network-security-policy"
    type = "network"
    policy = jsonencode([
        {
            Description = "Allowing access from any resource in the AWS account",
            Rules = [
                {
                    ResourceType = "collection",
                    Resource = [
                        "collection/${local.collection_name}"
                    ]
                }
            ],
            AllowFromPublic = true,
        },
        {
            Description = "Allowing access for dashboards from any resource in the AWS account",
            Rules = [
                {
                    ResourceType = "dashboard",
                    Resource = [
                        "collection/${local.collection_name}"
                    ]
                }
            ],
            AllowFromPublic = true,
        }
    ])
}


# Creating the data access policy
resource "aws_opensearchserverless_access_policy" "data_access_policy" {
    name = "${var.resource_prefix}-data-access-policy"
    type = "data"
    policy = jsonencode([
        {
            Rules = [
                {
                    ResourceType = "index",
                    Resource = [
                        "collection/${local.collection_name}/*"
                    ],
                    Permission = [
                        "aoss:*"
                    ]
                },
                {
                    ResourceType = "collection",
                    Resource = [
                        "collection/${local.collection_name}"
                    ],
                    Permission = [
                        "aoss:*"
                    ]
                }
            ],
            Principal = [
                "*"
            ]
        }
    ])
}



# Creating the OpenSearch Serverless collection
resource "aws_opensearchserverless_collection" "aoss_collection" {
    name = local.collection_name
    depends_on = [ aws_opensearchserverless_security_policy.encryption_policy ]
}