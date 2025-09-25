#!/bin/bash

set -e

# Script to set up the Kubernetes cluster with all prerequisites

# Step 1: Apply Terraform configuration to create EKS cluster
echo "Setting up EKS cluster with Terraform..."
cd terraform
terraform init
terraform apply -auto-approve
cd ..

# Step 2: Configure kubectl
echo "Configuring kubectl..."
aws eks update-kubeconfig --name tc-eks-cluster-tf --region us-east-1

# Step 3: Install NGINX Ingress Controller
echo "Setting up NGINX Ingress Controller..."
kubectl create namespace ingress-nginx --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f nginx/nginx-config.yaml
kubectl apply -f nginx/nginx-deployment.yaml

# Step 4: Install ArgoCD
echo "Setting up ArgoCD..."
kubectl create namespace argocd --dry-run=client -o yaml | kubectl apply -f -
kubectl apply -f argocd/install/install-argocd.yaml

# Wait for ArgoCD to be ready
echo "Waiting for ArgoCD to be ready..."
kubectl wait --for=condition=available --timeout=300s deployment/argocd-server -n argocd

# Step 5: Configure ArgoCD with projects and applications
echo "Configuring ArgoCD projects..."
kubectl apply -f argocd/projects/web-application.yaml

echo "Deploying applications..."
kubectl apply -f argocd/applications/

echo "Setup complete! Your cluster is now ready."
echo "ArgoCD UI should be available at: http://argocd.example.com"
echo "Default credentials: admin / $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)"