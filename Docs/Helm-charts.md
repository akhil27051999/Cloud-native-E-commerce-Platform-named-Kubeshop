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

### 📦 Sample Chart: `auth-chart`

```
auth-chart/
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
  repository: auth-service
  tag: v1
  pullPolicy: IfNotPresent
service:
  type: ClusterIP
  port: 5000
ingress:
  enabled: true
  path: /auth
  host: kube-shop.local
env:
  JWT_SECRET: mysecret
```

### 📄 deployment.yaml Template

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .Chart.Name }}
spec:
  replicas: {{ .Values.replicaCount }}
  selector:
    matchLabels:
      app: {{ .Chart.Name }}
  template:
    metadata:
      labels:
        app: {{ .Chart.Name }}
    spec:
      containers:
        - name: {{ .Chart.Name }}
          image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
          env:
            - name: JWT_SECRET
              valueFrom:
                secretKeyRef:
                  name: auth-secret
                  key: JWT_SECRET
          ports:
            - containerPort: 5000
```

### 🚀 Helm Commands

| Command                          | Purpose                         |
| -------------------------------- | ------------------------------- |
| `helm install auth ./auth-chart` | Deploy the chart to the cluster |
| `helm upgrade auth ./auth-chart` | Upgrade release with changes    |
| `helm uninstall auth`            | Remove the deployed release     |

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
