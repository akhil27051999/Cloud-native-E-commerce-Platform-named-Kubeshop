## 📘 Kube-Shop: A Complete Cloud-Native E-commerce DevOps Project

This project is a **microservices-based e-commerce platform** containerized with Docker, orchestrated via Kubernetes, and deployed through CI/CD pipelines using GitHub Actions and Jenkins. It follows GitOps principles using ArgoCD and includes Helm chart management and Kustomize-based environment overlays.

---

## 📁 Project Structure Overview

```
kube-shop/
├── microservices/          # Source code for each microservice
├── k8s-manifests/          # K8s base + overlays (Kustomize)
├── helm-charts/            # Helm charts per service
├── gitops/                 # ArgoCD GitOps deployment
├── ci-cd/                  # GitHub Actions + Jenkins pipelines
```

---

## 🔧 Microservices (Polyglot Stack & Docker Containerization)

### 1. `frontend/` (Node.js)

* **Function**: Provides the user interface for the e-commerce platform.
* **Why Node.js**: Fast, event-driven architecture suitable for responsive UIs.
* **Files**: `index.js`, `package.json`, `Dockerfile`
* **Containerization**:

  * Uses `node:alpine` as base image
  * Installs dependencies with `npm install`
  * Starts server with `node index.js`

### 2. `cart/` (Node.js)

* **Function**: Handles cart operations (add, remove, view items).
* **Why**: Code reuse with frontend and efficient async I/O handling
* **Containerization**:

  * Similar to frontend, shares Dockerfile structure and runtime

### 3. `auth/` (Python - Flask)

* **Function**: User authentication, registration, and JWT management
* **Why Python**: Fast prototyping, rich auth libraries
* **Containerization**:

  * Uses `python:3.9-slim`
  * Installs via `requirements.txt`
  * Runs via `python app.py` or `gunicorn`

### 4. `payments/` (Go)

* **Function**: Processes payments and transaction validations
* **Why Go**: Excellent performance, compiled binaries
* **Containerization**:

  * Multi-stage Dockerfile: `go build` → alpine/scratch base
  * Minimal final image size

### 5. `product/` (Java Spring Boot)

* **Function**: Handles product listings, categories, and inventory
* **Why Spring Boot**: Robust framework with enterprise support
* **Containerization**:

  * Uses Maven to build JAR
  * Runs with `java -jar ProductApplication.jar`

---

## ☸️ Kubernetes Configuration (Kustomize)

### `k8s-manifests/base/`

* **deployment.yaml**: Defines pod specs (image, env, probes)
* **service.yaml**: ClusterIP service for internal communication
* **configmap.yaml**: Non-sensitive configs like API endpoints
* **secret.yaml**: Encoded secrets (JWT, passwords)
* **ingress.yaml**: Ingress routing via NGINX
* **hpa.yaml**: Horizontal Pod Autoscaler for CPU-based scaling

### `k8s-manifests/overlays/`

* **dev/**: Few replicas, used for development
* **staging/**: Mimics production, for testing
* **prod/**: High availability, maximum resources

---

## 📦 Helm Charts (Reusable Packaging)

Each service has a Helm chart:

* **Chart.yaml**: Metadata
* **values.yaml**: Configuration inputs (replicas, image tag)
* **templates/**: Deployment, service, ingress, secrets, configmaps

**Why Helm**: Easy to upgrade, version, and reuse charts across environments

---

## 🚀 GitOps with ArgoCD

### GitOps Directory: `gitops/argo-cd-apps/`

* **app-of-apps.yaml**: Root app that manages all sub-apps
* **individual-apps/**: One YAML per microservice ArgoCD App

**Benefits**:

* Declarative source of truth in Git
* Auto-sync + rollback capabilities
* Easy multi-env management

---

## 🔄 CI/CD Pipelines

### GitHub Actions (`ci-cd/github-actions/`)

* Triggers on push to main branch
* Steps:

  * Checkout
  * Docker Build
  * Docker Push
  * ArgoCD Sync or K8s Deploy

### Jenkins Pipelines (`ci-cd/jenkins/`)

* Uses `Jenkinsfile-*` per service
* Custom stages for:

  * Build
  * Push
  * Helm/K8s Deploy

**Why Both**: Flexibility — GitHub Actions for lightweight automation, Jenkins for enterprise workflows

---

## 🌐 Ingress + HPA + Secrets

* **Ingress**: NGINX Ingress controller handles external access
* **Secrets**: Secure password/token handling (base64 encoded)
* **HPA**: Auto-scales services during load peaks

---

## 📊 Monitoring (Optional Add-ons)

* **Prometheus + Grafana**: Metric scraping and dashboards
* **Loki + Fluentd + Kibana**: Central log aggregation
* **Istio + Kiali**: Optional service mesh for observability

---

## 🧪 Testing & Validation

* **Service Unit Tests**: Each microservice supports tests (not shown here)
* **CI Validation**: Linting (YAML, Docker, Helm)
* **ArgoCD**: Verifies sync health after every deployment

---

## 📖 Deployment Guide

### 1. Clone Repo

```bash
git clone https://github.com/your-org/kube-shop.git
cd kube-shop
```

### 2. Build & Push Docker Images

```bash
docker build -t your-dockerhub/frontend microservices/frontend
# Repeat for other services
docker push your-dockerhub/frontend
```

### 3. Apply ArgoCD App

```bash
kubectl apply -f gitops/argo-cd-apps/app-of-apps.yaml
```

### 4. CI/CD Trigger

* GitHub: Push → Workflow executes
* Jenkins: Trigger manually or schedule jobs

---

## 📁 Project Summary

* ✔️ 5 microservices in Node.js, Python, Go, Java
* ✔️ Dockerized and stored in DockerHub
* ✔️ Kubernetes manifests managed by Kustomize
* ✔️ Helm charts for reuse and lifecycle mgmt
* ✔️ GitOps with ArgoCD
* ✔️ GitHub Actions + Jenkins Pipelines
* ✔️ Ready for Prometheus, Grafana, Loki, Istio integrations

---

## 👨‍💻 Author

**Your Name**
DevOps Engineer | Cloud-Native Enthusiast
