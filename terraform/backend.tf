terraform {
  backend "gcs" {
    bucket = "my-deploy-bucket-ariyans-learning-hub"
    prefix = "envs/dev/terraform.tfstate"
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
  }
}
