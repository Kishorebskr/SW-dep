# Tech assignment – GitOps-driven Helm Deployment with Terraform & ArgoCD

This repoository demonstrates the end-to-end automation of Kubernetes application deployment on Amazon EKS using **Terraform, Helm, ArgoCD, and GitHub Actions**. It includes Terraform configurations to provision the underlying AWS infrastructure, Helm charts to package and configure the application, ArgoCD manifests to enable GitOps-based deployments, and CI/CD workflows to automate Helm packaging and deployment.

---

## Repository Contents ####

### Terraform
- **eks.tf**: I Defined the EKS cluster and nodee group resources to host the Kubernetes workloads.
- **vpc.tf**: Here the configurations for the networking layer including VPC, subnets, and routing for EKS has been established.
- **variables.tf**: This terraform file contains parameterized input variables for reusability and flexible infrastructure configuration.
- **versions.tf**: It Specifies the provider and Terraform version constraints to ensure reproducibility.

### Helm & Kubernetes Manifests
- **Chart.yaml**: The file contains the metadataa definition for the Helm chart, including details such as the chart name, version, and description, which are essential for packaging and identifying the chart in a Helm repository.
- **values.yaml**: This YAML file defines the base configuration values for the application, serving as the default input for all Helm templates and ensuring a consistent configuration across environments unless overridden.
- **values/dev.yaml & values/prod.yaml**: This file specifically have the configuration between dev and prod environments.
- **deployment.yaml**: It Defines the application Deployment with replica sets and resource management.
- **service.yaml**: it controls and exposes the application internallly within the cluster.
- **ingress.yaml**: Here the external access to the application that is managed via Ingress Controller.
- **configmap.yaml & nginx-config.yaml**: This setup provide application configuration and custom NGINX rules.
- **NOTES.txt & helpers.tpl**: These helper files contain post-installation guidance and reusable Helm template functions, improving chart maintainability and offering instructions or hints to users after deploying the chart..

### ArgoCD
- **application-dev.yaml**: This will be used to Register the development environment Helm release with ArgoCD.
- **application-prod.yaml**: And this is to Register the production environment Helm release with the help of ArgoCD.

And here i made it like ArgoCD ensures that Git remains the single source of truth, automatically syncing any changes pushed to the repo into the cluster.

### CI/CD
- **package-chart.yml**: And it is the GitHub Actions workflow to build, package, and publish Helm charts.
- **deploy-chart.yml**: It used to automate deployment of Helm charts to Kubernetes via ArgoCD.

Both workflows enforce GitOps best practices by tying infrastructure and deployment automation directly to Git commits.

### Scripts
- **deploy-chart.sh**: It Automates deployment of Helm charts.
- **package-chart.sh**: This will Packages the Helm chart for release.
- **update-values.py**: It helps to dynamically updates Helm chart values for different environments.

---

## Highlights
- Here the GitOps model has been established using **ArgoCD**, where Kubernetes deployments automatically reconcile with the desired state stored in Git.
- In addition to that the Infrastructure provisioning automated with **Terraform**, ensuring repeatability and scalability.
- **Environment-specific Helm values** This will particulary make it easy to customize deployments for development and production.
- **End-to-end CI/CD pipeline** powered by GitHub Actions ensures packaging, validation, and automated rollouts.
- This is a Ready-to-use scripts for Helm operations to simplify local developer workflows.

---

## Security
- Sensitive credentials like AWS keys and kubeconfig are stored securely in GitHub Actions secrets.
- The repo design allows future enforcement of **branch protection policies**, **environment approvals**, and **restricted container registries**.
- In a production environment, **OIDC authentication** can be enabled for GitHub Actions to replace static AWS credentials.

---

## Possible Enhancements(Not Implemented Here)
- I can implement Readiness and liveness probes in Deployment manifests for better pod health management.
- Additionally the Pod Security Policies(PSP) or Pod Security Standards can be enforced for  compliance.
- As a best practice I can Use **Terraform remote backend** (S3 + DynamoDB) for production-ready state management.
- Autoscaling policies(HPA could be added to improve resilience under load.

---

## CI/CD Pipeline Flow
1. Once the Developer pushes code changes to GitHub.
2. **package-chart.yml** And it packages Helm charts and optionally uploads artifacts.
3. **deploy-chart.yml** Following to that this deploys Helm chart changes automatically to EKS.
4. ArgoCD continuously monitors the repo and reconciles Kubernetes manifests with Git.
5. And the Rollouts are verified using `kubectl rollout status`.

---

## Repository Structure
```
repo/
 ├── terraform-aws-gitops/
 │   ├── eks.tf
 │   ├── vpc.tf
 │   ├── variables.tf
 │   └── versions.tf
 │
 ├── helm-gitops-project/
 │   ├── charts/webapp/
 │   │   ├── templates/
 │   │   │   ├── deployment.yaml
 │   │   │   ├── service.yaml
 │   │   │   ├── ingress.yaml
 │   │   │   └── configmap.yaml
 │   │   ├── values.yaml
 │   │   ├── values/dev.yaml
 │   │   └── values/prod.yaml
 │   │
 │   ├── argocd/
 │   │   ├── application-dev.yaml
 │   │   └── application-prod.yaml
 │   │
 │   └── scripts/
 │       ├── deploy-chart.sh
 │       ├── package-chart.sh
 │       └── update-values.py
 │
 ├── .github/
 │   └── workflows/
 │       ├── package-chart.yml
 │       └── deploy-chart.yml
 │
 ├── argocdsetup
 └── README.md
```

---

## References
- Some parts of this work were assisted using GitHub Copilot, primarily for boilerplate generation and formatting like terrafrom resource block.
- [Terraform EKS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)
- [Helm Documentation](https://helm.sh/docs/)
- [ArgoCD Official Docs](https://argo-cd.readthedocs.io/)
- [GitHub Actions Security Best Practices](https://docs.github.com/en/actions/security-guides/security-hardening-for-github-actions)

---

## HLD Architecture
I made this solution to be fully deployable and opted with GitOps-based operations.  
A high-level architecture diagram (HLD) can illustrate the workflow of:
- AWS infra provisioned by Terraform
- Kubernetes workloads deployed with Helm
- GitOps synchronization via ArgoCD
- CI/CD orchestrated with GitHub Actions

---

This repository is production-ready with extensibility for enhancements, and I am capable of performing a **live demonstration on AWS** if required.
