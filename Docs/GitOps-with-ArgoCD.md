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

## Outputs

### GitOps with Argo CD showing all Applications Sync and Health Status
![Screenshot 2025-06-23 232810](https://github.com/user-attachments/assets/af9e4917-95ea-411c-843e-7068462b9e38)

### GitOps with ArgoCD showing Sync and Health Status of App-of-Apps
![Screenshot 2025-06-23 232335](https://github.com/user-attachments/assets/25ade2e2-5259-4282-9b43-e93a50b562bd)

### GitOps with ArgoCD showing Sync and Health Status of Frontend Microservice
![Screenshot 2025-06-23 232223](https://github.com/user-attachments/assets/da27193f-a1a7-421b-9f5d-6a1f093867ca)

### GitOps with ArgoCD showing Sync and Health Status of Cart Microservice
![Screenshot 2025-06-23 232244](https://github.com/user-attachments/assets/33ba1354-52ca-47a1-8b9c-deb6eae7b9b8)

### GitOps with ArgoCD showing Sync and Health Status of Payments Microservice
![Screenshot 2025-06-23 232419](https://github.com/user-attachments/assets/87e00437-0616-4af0-8fe2-17bbacab08b6)

### GitOps with ArgoCD showing Sync and Health Status of Product Microservice
![Screenshot 2025-06-23 232439](https://github.com/user-attachments/assets/8d044f08-c909-4fe3-94bb-26d4393cd7b7)


