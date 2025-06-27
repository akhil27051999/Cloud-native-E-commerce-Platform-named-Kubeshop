# 🚀 Section 4: GitOps Deployment with ArgoCD

This section explains how ArgoCD was used to manage and automate Kubernetes deployments using GitOps principles.

### 🔁 What is GitOps?

GitOps is a DevOps methodology where **Git is the single source of truth** for infrastructure and application deployments. Any changes to infrastructure are made through Git commits, and deployment tools like ArgoCD automatically apply those changes to your cluster.

### 📦 ArgoCD Setup

* ArgoCD is deployed in the `argocd` namespace.
* UI is exposed via a LoadBalancer or Ingress.
* Sync policies are defined per environment.

### 📁 Folder Structure

```
gitops/
├── individual-apps/
│   ├── cart-app.yaml
│   ├── auth-app.yaml
│   ├── frontend-app.yaml
│   ├── payments-app.yaml
│   └── product-app.yaml
└── app-of-apps.yaml    # App of Apps pattern
```

### 🔄 App of Apps Pattern

```yaml
# gitops/app-of-apps.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: kube-shop-app-of-apps
  namespace: argocd
spec:
  destination:
    namespace: default
    server: https://kubernetes.default.svc
  project: default
  source:
    repoURL: https://github.com/akhil27051999/Cloud-native-E-commerce-Platform-named-kubeshop.git
    targetRevision: main
    path: gitops/individual-apps
    directory:
      recurse: true
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true
```

🎯 This pattern helps manage multiple ArgoCD applications from a single parent manifest.

### 🔗 Application Example

```yaml
# gitops/individual-apps/cart-app.yaml
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: cart-app
  namespace: argocd
spec:
  destination:
    namespace: cart
    server: https://kubernetes.default.svc
  project: default
  source:
    repoURL: https://github.com/akhil27051999/Cloud-native-E-commerce-Platform-named-kubeshop.git
    targetRevision: main
    path: k8s-manifests/overlays/dev
    kustomize:
      namePrefix: cart-
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
    syncOptions:
      - CreateNamespace=true

```

### ✅ Benefits of Using ArgoCD

| Feature           | Benefit                                                      |
| ----------------- | ------------------------------------------------------------ |
| Declarative Setup | Define everything in Git and apply via ArgoCD                |
| Visibility        | UI and CLI tools for monitoring and syncing applications     |
| Auto Sync         | Automatically applies Git changes to the cluster             |
| Rollbacks         | Easily roll back to any previous commit/version              |
| GitOps Workflow   | Matches modern CI/CD and platform engineering best practices |

