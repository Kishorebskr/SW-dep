#!/bin/bash

set -e

# Script to update application version in environment values files
# Usage: ./update-values.sh <environment> <version>

ENVIRONMENT=$1
VERSION=$2

if [[ -z "$ENVIRONMENT" || -z "$VERSION" ]]; then
  echo "Usage: ./update-values.sh <environment> <version>"
  exit 1
fi

VALUES_FILE="./helm/web-application/environments/${ENVIRONMENT}.yaml"

if [[ ! -f "$VALUES_FILE" ]]; then
  echo "Error: Values file for environment '${ENVIRONMENT}' not found at ${VALUES_FILE}"
  exit 1
fi

# Update the version in the values file
# This assumes yq is installed - if not using yq, we could use sed
if command -v yq &> /dev/null; then
  # Using yq to modify the YAML
  yq eval ".image.tag = \"$VERSION\"" -i "$VALUES_FILE"
else
  # Fallback to sed (less reliable for YAML but works in a pinch)
  if grep -q "tag:" "$VALUES_FILE"; then
    sed -i "s/tag: .*/tag: $VERSION/" "$VALUES_FILE"
  else
    # If tag doesn't exist, add it under image
    sed -i "/image:/a \  tag: $VERSION" "$VALUES_FILE"
  fi
fi

echo "Updated $ENVIRONMENT environment to use version $VERSION"