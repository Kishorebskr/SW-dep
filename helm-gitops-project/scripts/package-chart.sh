#!/bin/bash

# Navigate to the chart directory
cd charts/webapp

# Package the Helm chart
helm package .

# Move the packaged chart to the parent directory
mv *.tgz ../

# Print a success message
echo "Helm chart packaged successfully."