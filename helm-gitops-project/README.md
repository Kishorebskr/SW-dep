# Helm GitOps Project

This project provides a standardized approach to deploying simple web applications across multiple Kubernetes clusters using Helm charts and a GitOps methodology. The goal is to ensure flexible yet consistent deployments across different environments while simplifying management and maintenance.

## Project Structure

The project is organized as follows:

```
helm-gitops-project
├── .github
│   └── workflows
│       └── ci-cd.yml          # GitHub Actions workflow for CI/CD
├── environments
│   ├── dev
│   │   └── values.yaml        # Development environment configuration
│   ├── prod
│   │   └── values.yaml        # Production environment configuration
│   └── staging
│       └── values.yaml        # Staging environment configuration
├── helm-chart
│   ├── templates
│   │   ├── _helpers.tpl       # Helper templates for reuse
│   │   ├── deployment.yaml     # Kubernetes Deployment resource
│   │   ├── ingress.yaml        # Ingress resource for external access
│   │   ├── NOTES.txt           # Notes and instructions post-deployment
│   │   └── service.yaml        # Kubernetes Service resource
│   ├── Chart.yaml              # Metadata about the Helm chart
│   └── values.yaml             # Default configuration values
├── scripts
│   └── deploy.sh               # Automation script for deployment
└── README.md                   # Project documentation
```

## Features

- **Configurable Deployment**: Easily configure the deployment name, namespace, port, and ingress hostnames through environment-specific values files.
- **GitOps Approach**: Leverage GitHub Actions for CI/CD to automate the packaging and deployment of Helm charts.
- **Multi-Environment Support**: Separate values files for development, staging, and production environments to ensure tailored configurations.

## Getting Started

### Prerequisites

- A Kubernetes cluster (local or cloud-based)
- Helm installed on your local machine
- Access to a GitHub repository for CI/CD

### Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd helm-gitops-project
   ```

2. **Configure Environment Values**:
   Update the `values.yaml` files in the `environments` directory to set your desired configurations for each environment.

3. **Deploy the Application**:
   Use the provided `deploy.sh` script to package and deploy the Helm chart:
   ```bash
   ./scripts/deploy.sh <environment>
   ```
   Replace `<environment>` with `dev`, `staging`, or `prod`.

4. **Access the Application**:
   After deployment, follow the instructions in `helm-chart/templates/NOTES.txt` to access your application.

## CI/CD Workflow

The GitHub Actions workflow defined in `.github/workflows/ci-cd.yml` automates the following steps:

- Package the Helm chart
- Update custom values based on the environment
- Deploy the Helm chart to the specified Kubernetes cluster

## Conclusion

This project provides a robust framework for deploying web applications using Helm and GitOps principles. By following the setup instructions, you can easily manage deployments across multiple environments while maintaining consistency and flexibility.