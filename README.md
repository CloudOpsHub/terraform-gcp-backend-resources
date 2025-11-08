Add this theree values repo secrets

GCP_PROJECT_ID
learning-hub

GCP_SERVICE_ACCOUNT_EMAIL
github-deployer@learning-hub.iam.gserviceaccount.com

GCP_WORKLOAD_IDENTITY_PROVIDER
projects/3034234223438/locations/global/workloadIdentityPools/github-pool/providers/github-provider

🧩 Prerequisites

Before running this workflow, make sure you’ve done these:

Enabled APIs

gcloud services enable iam.googleapis.com iamcredentials.googleapis.com artifactregistry.googleapis.com run.googleapis.com


Created service account & granted permissions

gcloud iam service-accounts create github-deployer \
  --display-name="GitHub Deployer"

gcloud projects add-iam-policy-binding <PROJECT_ID> \
  --member="serviceAccount:github-deployer@<PROJECT_ID>.iam.gserviceaccount.com" \
  --role="roles/run.admin"

gcloud projects add-iam-policy-binding <PROJECT_ID> \
  --member="serviceAccount:github-deployer@<PROJECT_ID>.iam.gserviceaccount.com" \
  --role="roles/iam.serviceAccountUser"


Created Workload Identity Pool & Provider (as discussed earlier):

gcloud iam workload-identity-pools create "github-pool" \
  --location="global" \
  --display-name="GitHub Pool"

gcloud iam workload-identity-pools providers create-oidc "github-provider" \
  --workload-identity-pool="github-pool" \
  --location="global" \
  --display-name="GitHub OIDC Provider" \
  --issuer-uri="https://token.actions.githubusercontent.com" \
  --attribute-mapping="google.subject=assertion.sub,attribute.repository=assertion.repository" \
  --attribute-condition="assertion.repository=='subash-org/infra-deploy'"


Bind the GitHub repo to impersonate the service account

gcloud iam service-accounts add-iam-policy-binding github-deployer@<PROJECT_ID>.iam.gserviceaccount.com \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/<PROJECT_NUMBER>/locations/global/workloadIdentityPools/github-pool/attribute.repository/subash-org/infra-deploy"
