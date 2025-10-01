
CHART_NAME="webapp"
NAMESPACE="default"
VALUES_FILE="values.yaml"
RELEASE_NAME="webapp-release"

if [ "$1" == "dev" ]; then
    VALUES_FILE="values/dev.yaml"
    RELEASE_NAME="${RELEASE_NAME}-dev"
elif [ "$1" == "prod" ]; then
    VALUES_FILE="values/prod.yaml"
    RELEASE_NAME="${RELEASE_NAME}-prod"
fi

helm upgrade --install "$RELEASE_NAME" "./charts/$CHART_NAME" -n "$NAMESPACE" -f "./charts/$CHART_NAME/$VALUES_FILE" --wait --timeout 300s

if [ $? -eq 0 ]; then
    echo "Deployment of $RELEASE_NAME to namespace $NAMESPACE was successful."
else
    echo "Deployment of $RELEASE_NAME failed."
    exit 1
fi