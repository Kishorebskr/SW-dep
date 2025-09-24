resource "helm_release" "argocd" {
  count       = var.gitops_install_argocd ? 1 : 0
  name        = "argocd"
  repository  = "https://argoproj.github.io/argo-helm"
  chart       = "argo-cd"
  version     = "6.7.2"
  namespace   = "argocd"
  create_namespace = true
  values = [<<EOF
server:
  service:
    type: LoadBalancer
EOF
  ]
  depends_on = [module.eks]
}
