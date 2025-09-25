# Kubernetes GitOps Project

This repository contains a complete GitOps workflow for deploying web applications to Kubernetes using Helm charts, ArgoCD, and automation via GitHub Actions.

## Architecture

- **Terraform**: Provisions the EKS cluster and related infrastructure
- **Helm Charts**: Standardized application deployment configuration
- **ArgoCD**: GitOps continuous delivery tool
- **NGINX**: Reverse proxy and load balancer
- **GitHub Actions**: CI/CD automation

## Prerequisites

- AWS CLI configured
- Terraform >= 1.3
- kubectl
- Helm v3
- yq (optional, for values file manipulation)

## Getting Started

1. Clone this repository
2. Update the S3 bucket in `terraform/main.tf` with your actual bucket name
3. Run the setup script:

```bash
chmod +x scripts/setup-cluster.sh
./scripts/setup-cluster.sh