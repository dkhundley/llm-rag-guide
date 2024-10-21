## DATA BLOCKS
## --------------------------------------------------------------------------------------------------------------



## RESOURCE BLOCKS
## --------------------------------------------------------------------------------------------------------------
# Creating an encryption security policy
resource "aws_opensearchserverless_security_policy" "encryption_policy" {
    name = "${var.resource_prefix}-encryption-policy"
    type = "encryption"
    description = "Policy for encryption at rest for ${var.resource_prefix} OpenSearch Service domain"
    policy = jsonencode({
        Rules = [
            {
                Resource = [
                    "${aws_opensearchserverless_domain.domain.arn}"
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
            Description = "VPC access for collection endpoint",
            Rules = [
                {
                    ResourceType = "collection",
                    Resource = [
                        "collection/${var.collection_name}"
                    ]
                }
            ],
            AllowFromPublic = false,
            SourceVPCEs = [
                aws_opensearchserverless_vpc_endpoint.vpc_endpoint.id
            ]
        },
        {
            Description = "Public access for dashboards",
            Rules = [
                {
                    ResourceType = "dashboard"
                    Resource = [
                        "collection/${var.collection_name}"
                    ]
                }
            ],
            AllowFromPublic = true
        }
    ])
}