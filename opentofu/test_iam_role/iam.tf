## DATA BLOCKS
## --------------------------------------------------------------------------------------------------------------
# Setting the "Assume Role" information
data "aws_iam_policy_document" "assume_role_document" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
            type = "Service"
            identifiers = ["lambda.amazonaws.com"]
        }
    }
}

# Setting the IAM policy information
data "aws_iam_policy_document" "policy_document" {

    statement {
        actions = [
            "s3:GetObject",
            "s3:ListBucket",
        ]
        resources = ["*"]
    }
}



## RESOURCE BLOCKS
## --------------------------------------------------------------------------------------------------------------
# Creating the IAM role
resource "aws_iam_role" "iam_role" {
  name = "${local.prefix}-role"
  assume_role_policy = data.aws_iam_policy_document.assume_role_document.json
}

# Creating the IAM policy
resource "aws_iam_policy" "iam_policy" {
    name = "${local.prefix}-policy"
    policy = data.aws_iam_policy_document.policy_document.json
}

# Attaching the IAM policy to the IAM role
resource "aws_iam_role_policy_attachment" "iam_policy_attachment" {
    role = aws_iam_role.iam_role.name
    policy_arn = aws_iam_policy.iam_policy.arn
}