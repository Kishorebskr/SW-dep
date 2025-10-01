
cd charts/webapp

helm package .

mv *.tgz ../

echo "Helm chart packaged successfully."