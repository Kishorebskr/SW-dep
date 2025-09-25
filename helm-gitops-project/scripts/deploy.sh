#!/bin/bash

# Set the environment variable based on the first argument
ENVIRONMENT=$1

# Check if the environment argument is provided
if [ -z "$ENVIRONMENT" ]; then
  echo "Usage: $0 <environment>"
  exit 1
fi

# Define the Helm chart directory and values file
CHART_DIR="./helm-chart"
VALUES_FILE="./environments/$ENVIRONMENT/values.yaml"

# Check if the values file exists
if [ ! -f "$VALUES_FILE" ]; then
  echo "Values file for environment '$ENVIRONMENT' not found!"
  exit 1
fi

# Package the Helm chart
echo "Packaging Helm chart..."
helm package $CHART_DIR

# Update the custom values (this can be customized as needed)
echo "Updating values for environment '$ENVIRONMENT'..."
# Example: Update app version in values.yaml (this is just a placeholder)
# sed -i 's/version: .*/version: 1.0.1/' $VALUES_FILE

# Deploy the Helm chart to the Kubernetes cluster
echo "Deploying Helm chart to Kubernetes cluster..."
helm upgrade --install "${ENVIRONMENT}-webapp" $CHART_DIR --values $VALUES_FILE

echo "Deployment to '$ENVIRONMENT' environment completed."