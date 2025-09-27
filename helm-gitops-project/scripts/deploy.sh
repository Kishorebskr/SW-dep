#!/bin/bash

# Set the environment variable based on the first argument
ENVIRONMENT=$1
VERSION=$2

# Check if the required arguments are provided
if [ -z "$ENVIRONMENT" ] || [ -z "$VERSION" ]; then
  echo "Usage: $0 <environment> <version>"
  echo "Example: $0 dev 1.0.0"
  exit 1
fi

# Define the Helm chart directory and values file
CHART_DIR="./helm-chart"
VALUES_FILE="./environments/$ENVIRONMENT/values.yaml"
CHART_PACKAGE="web-app-$VERSION.tgz"

# Check if the values file exists
if [ ! -f "$VALUES_FILE" ]; then
  echo "Values file for environment '$ENVIRONMENT' not found!"
  exit 1
fi

# Package the Helm chart
echo "Packaging Helm chart..."
helm package $CHART_DIR --version $VERSION --app-version $VERSION

# Update app version in values file
echo "Updating app version to $VERSION in $VALUES_FILE..."
sed -i "s|tag:.*|tag: \"$VERSION\"|g" $VALUES_FILE

# Deploy the Helm chart to the Kubernetes cluster
echo "Deploying Helm chart to Kubernetes cluster..."
helm upgrade --install "${ENVIRONMENT}-webapp" $CHART_PACKAGE --values $VALUES_FILE --namespace $ENVIRONMENT --create-namespace

echo "Deployment to '$ENVIRONMENT' environment completed with version $VERSION."