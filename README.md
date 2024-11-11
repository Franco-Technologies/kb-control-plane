# kb-control-plane

## Overview

The `kb-control-plane` project is part of a SaaS framework designed to manage the infrastructure for the Knowledge Base application. This module specifically handles the deployment of a VPC, load balancer, and API Gateway integration for control plane microservices. It uploads details of this infrastructure to AWS SSM to be used by any microservice that will be deployed into this VPC.

## Modules

The project is organized into several Terraform modules:

- **VPC**: Manages the Virtual Private Cloud and its subnets.
- **Load Balancer**: Configures both Application and Network Load Balancers.
- **API Gateway**: Sets up the API Gateway for routing requests.
- **SSM**: Stores configuration parameters in AWS Systems Manager Parameter Store.

## CI/CD Pipeline

The project includes a CI/CD pipeline configured using GitHub Actions. The pipeline is defined in the `.github/workflows/terraform.yml` file and is triggered on pushes and pull requests to the `main` and `dev` branches.

### Dependencies

- **Terraform**: The pipeline requires Terraform to be installed and configured.
- **AWS CLI**: The AWS CLI must be configured with appropriate credentials.
- **GitHub Secrets**: The following secrets must be set in the GitHub repository:
  - `AWS_ACCESS_KEY_ID`
  - `AWS_SECRET_ACCESS_KEY`
  - `PAT` (Personal Access Token for GitHub)

The pipeline performs the following actions:

- Initializes the Terraform configuration.
- Plans the Terraform deployment.
- Applies the Terraform configuration to provision the infrastructure.
- The app name is used to retrieve API Gateway details and other configuration details from AWS SSM.
