data "http" "lbc_iam_policy_document" {
  url = "https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/main/docs/install/iam_policy.json"

# Optional 
  request_headers = {
    Accept = "application/json"
  }
}   


