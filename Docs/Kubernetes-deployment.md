# 📦 Section 2: Kubernetes Deployment (YAML-based)

This section details how we deployed all five microservices (auth, cart, frontend, payments, and product) onto a Kubernetes cluster using Kubernetes manifests written in YAML. The deployments are structured using the base-overlay model to support multi-environment deployment strategies.

### 📁 Folder Structure

```
k8s-manifests/
├── base/
│   └── [service-name]/
│       ├── deployment.yaml
│       ├── service.yaml
│       ├── configmap.yaml
│       ├── secret.yaml
│       ├── ingress.yaml
│       └── hpa.yaml
└── overlays/
    ├── dev/
    ├── staging/
    └── prod/
```

### 🔨 Components Explained (Per Microservice)

| File            | Purpose                                                             |
| --------------- | ------------------------------------------------------------------- |
| deployment.yaml | Defines pod spec, container image, ports, env, and labels.          |
| service.yaml    | Exposes the app as a ClusterIP/NodePort for internal communication. |
| configmap.yaml  | Stores configuration parameters like ENV values.                    |
| secret.yaml     | Stores sensitive credentials (e.g., DB URIs, JWT keys).             |
| ingress.yaml    | Exposes services externally with domain routing.                    |
| hpa.yaml        | Auto-scales pods based on CPU or memory usage.                      |

### ⚙️ Base Deployment Setup

All microservices share a common structure in `k8s-manifests/base/[service]/`. These manifests define the reusable infrastructure configuration for each service.

**Example: cart Microservice**

```yaml
# cart/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cart
spec:
  replicas: 2
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
          image: akhilthyadi/kube-cart:latest
          ports:
            - containerPort: 5000
          envFrom:
            - configMapRef:
                name: cart-config
            - secretRef:
                name: cart-secret

```

```yaml
# cart/service.yaml
apiVersion: v1
kind: Secret
metadata:
  name: cart-secret
type: Opaque
data:
  DB_PASSWORD: cmVkaXNfcGFzcw==

```

### 🔁 Multi-Environment Support with Kustomize

To handle separate environments (dev, staging, prod), we use Kustomize overlays.

**Overlay Directory Sample:**

```yaml
# overlays/dev/kustomization.yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization


patchesStrategicMerge:
- patches/auth-replica-patch.yaml
- patches/cart-replica-patch.yaml
- patches/frontend-replica-patch.yaml
- patches/payments-replica-patch.yaml
- patches/product-replica-patch.yaml
resources:
- ../../base/auth
- ../../base/cart
- ../../base/frontend
- ../../base/payments
- ../../base/product

```

```yaml
# overlays/dev/patches/cart-replica-patch.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cart
spec:
  replicas: 2

```

🎯 Purpose: Kustomize overlays let you define environment-specific changes without modifying the base manifests.

### 🌐 Ingress Routing

All services are exposed externally via an Ingress controller (like NGINX).

```yaml
# ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: cart-ingress
spec:
  rules:
    - host: cart.kubeshop.local
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: cart-service
                port:
                  number: 3000
```

### 📈 Autoscaling (HPA)

```yaml
# hpa.yaml
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: cart-hpa
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: cart
  minReplicas: 2
  maxReplicas: 5
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 60

```

### ✅ Result

| Component        | Deployed With  | Result                                         |
| ---------------- | -------------- | ---------------------------------------------- |
| Deployment       | kubectl        | Deploys each microservice container on pods.   |
| Service          | ClusterIP      | Internal networking between services.          |
| Ingress          | Host-based     | Public exposure on custom domains.             |
| ConfigMap/Secret | Declarative    | Secure and configurable environment variables. |
| HPA              | Resource-based | Auto-scaling based on CPU utilization.         |
| Kustomize        | YAML patches   | Supports clean dev/staging/prod setup.         |

### 🧪 Test the Deployment Locally (with Minikube or kind)

```bash
# Apply base config for testing
kubectl apply -k k8s-manifests/overlays/dev/

# Check running pods
kubectl get pods

# Test ingress
curl http://cart.kubeshop.local
```

### 🎯 Why This Approach?

| Feature              | Benefit                                            |
| -------------------- | -------------------------------------------------- |
| Modular Structure    | Easy to maintain per-service config.               |
| Reusability          | Base and overlays split logic cleanly.             |
| GitOps Ready         | Easily integrated with ArgoCD or Flux.             |
| Environment Specific | Replica counts, secrets, and resource limits vary. |

## Outputs

### Pods Status of all Microservices

![Screenshot 2025-06-21 003009](https://github.com/user-attachments/assets/6d45d09d-d544-451e-a3d7-14fb2583c777)


