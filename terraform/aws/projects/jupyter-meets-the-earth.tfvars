region = "us-west-2"

cluster_name = "jupyter-meets-the-earth"

cluster_nodes_location = "us-west-2a"

default_budget_alert = {
  "enabled" : false,
}

# Remove this variable to tag all our resources with {"ManagedBy": "2i2c"}
tags = {}

user_buckets = {
  "scratch-staging" : {
    "delete_after" : 7
  },
  // IMPORTANT: This bucket isn't used, they are instead using s3://jmte-scratch
  //            that doesn't have a delete_after policy setup etc, but maybe
  //            they want to have.
  "scratch" : {
    "delete_after" : 7
  },
}


hub_cloud_permissions = {
  "staging" : {
    "user-sa" : {
      bucket_admin_access : ["scratch-staging"],
      # FIXME: Previously, users were granted full S3 permissions.
      # Keep it the same for now
      extra_iam_policy : <<-EOT
        {
          "Version": "2012-10-17",
          "Statement": [
            {
              "Effect": "Allow",
              "Action": ["s3:*"],
              "Resource": ["arn:aws:s3:::*"]
            }
          ]
        }
      EOT
    },
  },
  "prod" : {
    "user-sa" : {
      bucket_admin_access : ["scratch"],
      # FIXME: Previously, users were granted full S3 permissions.
      # Keep it the same for now
      extra_iam_policy : <<-EOT
        {
          "Version": "2012-10-17",
          "Statement": [
            {
              "Effect": "Allow",
              "Action": ["s3:*"],
              "Resource": ["arn:aws:s3:::*"]
            }
          ]
        }
      EOT
    },
  },
}
