# Helm GitOps Project

This project provides a standardized approach to deploying simple web applications across multiple Kubernetes clusters using Helm charts and a GitOps methodology. The goal is to ensure flexible yet consistent deployments across different environments while simplifying management and maintenance.

## Project Structure

The project is organized as follows:

```
helm-gitops-project
├── .github
│   └── workflows
│       ├── package-chart.yml        # GitHub Actions workflow for packaging the Helm chart
│       └── deploy-chart.yml         # GitHub Actions workflow for deploying the Helm chart
├── charts
│   └── webapp
│       ├── Chart.yaml               # Metadata about the Helm chart
│       ├── values.yaml              # Default values for the Helm chart
│       ├── templates
│       │   ├── deployment.yaml       # Kubernetes Deployment resource template
│       │   ├── service.yaml          # Kubernetes Service resource template
│       │   ├── ingress.yaml          # Ingress resource template
│       │   ├── configmap.yaml        # ConfigMap resource template
│       │   ├── _helpers.tpl          # Helper templates
│       │   └── NOTES.txt             # Instructions after installation
│       └── values
│           ├── dev.yaml              # Development environment-specific values
│           └── prod.yaml             # Production environment-specific values
├── scripts
│   ├── package-chart.sh              # Script to package the Helm chart
│   ├── update-values.py              # Script to update custom values files
│   └── deploy-chart.sh                # Script to deploy the Helm chart
├── argocd
│   ├── application-dev.yaml           # ArgoCD application configuration for development
│   └── application-prod.yaml          # ArgoCD application configuration for production
└── README.md                          # Project documentation
```

## Features



- **Configurable Deployment**: The Helm chart allows for configurable deployment names, namespaces, ports, and ingress hostnames.
- **Environment-Specific Values**: Separate values files for development and production environments enable easy customization.
- **Automation Scripts**: Scripts are provided to automate the packaging and deployment of the Helm chart, as well as to update values files.

## Getting Started

1. **Prerequisites**:
   - Ensure you have [Helm](https://helm.sh/docs/intro/install/) installed.
   - Have access to a Kubernetes cluster.
   - Install [ArgoCD](https://argo-cd.readthedocs.io/en/stable/).

2. **Packaging the Helm Chart**:
   - Run the following command to package the Helm chart:
     ```
     ./scripts/package-chart.sh
     ```

3. **Updating Values**:
   - Use the Python script to update values in the custom values files:
     ```
     python scripts/update-values.py <environment> <key> <value>
     ```

4. **Deploying the Helm Chart**:
   - Deploy the chart to your Kubernetes cluster:
     ```
     ./scripts/deploy-chart.sh <environment>
     ```

5. **ArgoCD Setup**:
   - Configure ArgoCD applications using the provided YAML files in the `argocd` directory for both development and production environments.

## Contributing

Feel free to contribute to this project by submitting issues or pull requests. Ensure that you follow the project's coding standards and guidelines.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
