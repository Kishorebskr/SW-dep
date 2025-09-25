#!/bin/bash

set -e

# Script to package the Helm chart
CHART_DIR="./helm/web-application"
OUTPUT_DIR="./chart-packages"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Package the chart
echo "Packaging Helm chart..."
helm package "$CHART_DIR" -d "$OUTPUT_DIR"

echo "Chart packaged successfully!"