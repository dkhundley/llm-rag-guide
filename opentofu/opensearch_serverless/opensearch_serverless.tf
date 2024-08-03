# ## RESOURCE BLOCKS
# ## --------------------------------------------------------------------------------------------------------------
# # Creating the OpenSearch Serverless data encryption policy
# resource "aws_opensearchserverless_security_policy" "oss_security_policy" {
#   name = "${local.prefix}-oss-policy"
#   type = "encryption"
#   policy = jsonencode({
#     Rules = [
#       {
#         Resource = [
#           "collection/${local.prefix}-collection"
#         ],
#         ResourceType = "collection"
#       }
#     ],
#     AWSOwnedKey = true
#   })
# }



# # Creating the OpenSearch Serverless collection
# resource "aws_opensearchserverless_collection" "oss_collection" {
#   name = "${local.prefix}-collection"
#   type = "SEARCH"
#   depends_on = [aws_opensearchserverless_security_policy.oss_security_policy]
# }