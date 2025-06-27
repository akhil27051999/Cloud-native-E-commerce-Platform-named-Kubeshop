# 📦 Section 3: Helm Chart Packaging

This section focuses on packaging Kubernetes manifests as reusable Helm charts for each microservice. Helm simplifies deployment, versioning, and configuration of Kubernetes resources.

### 📁 Directory Structure

```
helm-charts/
├── auth-chart/
├── cart-chart/
├── frontend-chart/
├── payments-chart/
└── product-chart/
```

Each chart follows this standard structure:

| File / Directory | Purpose                                                |
| ---------------- | ------------------------------------------------------ |
| `Chart.yaml`     | Metadata about the chart (name, version, dependencies) |
| `values.yaml`    | Default configuration values (image, replicas, etc)    |
| `templates/`     | Contains Kubernetes resource templates                 |

### 📦 Sample Chart: `cart-chart`

```
cart-chart/
├── Chart.yaml
├── values.yaml
└── templates/
    ├── deployment.yaml
    ├── service.yaml
    ├── configmap.yaml
    ├── secret.yaml
    └── ingress.yaml
```

### 🔧 values.yaml Example

```yaml
replicaCount: 2

image:
  repository: akhilthyadi/kube-cart
  tag: latest
  pullPolicy: IfNotPresent

service:
  type: ClusterIP
  port: 5001

ingress:
  enabled: true
  path: /cart

config:
  CART_CACHE_TTL: "300"

resources: {}

```

### 📄 deployment.yaml Template

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cart
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: cart
  template:
    metadata:
      labels:
        app: cart
    spec:
      containers:
        - name: cart
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          ports:
            - containerPort: 5001
          envFrom:
            - configMapRef:
                name: cart-config
            - secretRef:
                name: cart-secret

```

### 🚀 Helm Commands

| Command                          | Purpose                         |
| -------------------------------- | ------------------------------- |
| `helm install cart ./cart-chart` | Deploy the chart to the cluster |
| `helm upgrade cart ./cart-chart` | Upgrade release with changes    |
| `helm uninstall cart`            | Remove the deployed release     |

✅ **Tip**: Use `helm lint` and `helm template` for validation and dry-runs.

### 🔄 GitOps Compatibility

* Helm charts are managed by ArgoCD using the `source.helm` configuration.
* Can be configured to auto-sync chart versions and values per environment.

### ✅ Helm Benefits

| Feature               | Description                                            |
| --------------------- | ------------------------------------------------------ |
| Reusability           | Parameterized and templatized for dynamic environments |
| Version Control       | Helm release history enables rollbacks                 |
| CI/CD Ready           | Integrates well with GitHub Actions and Jenkins        |
| Simplified Deployment | One command deploys all Kubernetes resources           |

---
