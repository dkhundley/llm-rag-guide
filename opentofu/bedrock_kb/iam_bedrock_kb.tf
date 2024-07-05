## DATA BLOCKS
## --------------------------------------------------------------------------------------------------------------
# Setting the "Assume Role" information
data "aws_iam_policy_document" "bedrock_kb_assume_role" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type = "Service"
            identifiers = ["bedrock.amazonaws.com"]
        }
    }
}

# Setting the IAM policy information
data "aws_iam_policy_document" "bedrock_kb_policy_document" {

    statement {
        actions = [
            "bedrock:CreateKnowledgeBase",
            "bedrock:GetKnowledgeBase",
            "bedrock:UpdateKnowledgeBase",
            "bedrock:DeleteKnowledgeBase",
            "bedrock:CreateDataSource",
            "bedrock:GetDataSource",
            "bedrock:UpdateDataSource",
            "bedrock:DeleteDataSource",
            "bedrock:ListKnowledgeBases",
            "bedrock:ListDataSources",
            "aoss:CreateCollection",
            "aoss:DeleteCollection",
            "aoss:UpdateCollection",
            "aoss:CreateAccessPolicy",
            "aoss:CreateSecurityPolicy",
            "aoss:GetAccessPolicy",
            "aoss:GetSecurityPolicy",
            "aoss:ListAccessPolicies",
            "aoss:ListSecurityPolicies",
            "aoss:UpdateAccessPolicy",
            "aoss:UpdateSecurityPolicy",
            "s3:GetObject",
            "s3:ListBucket",
            "ec2:DescribeVpcs",
            "ec2:DescribeSecurityGroups"
        ]
        resources = ["*"]
    }
}



## RESOURCE BLOCKS
## --------------------------------------------------------------------------------------------------------------
# Creating the IAM role
resource "aws_iam_role" "bedrock_kb_iam_role" {
  name = "${local.prefix}-role"
  assume_role_policy = data.aws_iam_policy_document.bedrock_kb_assume_role.json
}

# Creating the IAM policy
resource "aws_iam_policy" "bedrock_kb_iam_policy" {
    name = "${local.prefix}-policy"
    policy = data.aws_iam_policy_document.bedrock_kb_policy_document.json
}

# Attaching the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "bedrock_kb_policy_attachment" {
    role = aws_iam_role.bedrock_kb_iam_role.name
    policy_arn = aws_iam_policy.bedrock_kb_iam_policy.arn
}