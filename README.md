# 📦 Kube-Shop: Cloud-Native E-commerce Platform

A full-featured e-commerce application built with microservices using **Node.js**, **Python**, **Go**, and **Java**, containerized with **Docker**, deployed on **Kubernetes**, managed with **GitOps (ArgoCD)**, automated with **CI/CD (GitHub Actions & Jenkins)**, monitored via **Prometheus & Grafana**, and provisioned with **Terraform on AWS**.

<img width="1000" alt="monolithic-architecture" src="https://github.com/user-attachments/assets/f3409bb8-d292-444e-a686-49f0c1dfeabb" />
---

## 🌐 Live Features

* Microservices architecture (Auth, Cart, Frontend, Payments, Product)
* Kubernetes multi-environment setup with **Kustomize** overlays
* Helm chart support for each microservice
* CI/CD pipelines using GitHub Actions and Jenkins
* ArgoCD App of Apps for GitOps deployment
* AWS Infrastructure via Terraform (VPC, EKS, Node Groups)
* Monitoring with Prometheus, Grafana, and Alertmanager



### Pre-Requisites

* Docker
* Kubectl
* Minikube/Kind (for local Kubernetes testing)
* Terraform (v1.5+)
* AWS CLI configured
* ArgoCD & Helm installed

---

## 📁 Project Structure Overview

```
kube-shop/
├── microservices/                # Source code for all 5 microservices
│   ├── frontend/                 # Node.js
│   ├── cart/                     # Node.js
│   ├── auth/                     # Python Flask
│   ├── payments/                 # Go
│   └── product/                  # Java Spring Boot

├── k8s-manifests/               # Kubernetes YAMLs with base/overlay structure
│   ├── base/                    # Base manifests (deployment, service, ingress, etc.)
│   └── overlays/                # Kustomize overlays for dev/staging/prod

├── helm-charts/                 # Helm charts for each microservice
│   ├── [service]-chart/         # Individual Helm charts for auth, cart, etc.

├── gitops/                      # ArgoCD GitOps app configurations
│   └── argo-cd-apps/
│       ├── app-of-apps.yaml     # App of Apps definition
│       └── individual-apps/     # Each microservice’s ArgoCD Application manifest

├── ci-cd/                       # CI/CD workflows for GitHub Actions & Jenkins
│   ├── github-actions/          # GitHub Actions YAMLs for all services
│   └── jenkins/                 # Jenkinsfiles for all services

├── monitoring/                  # Prometheus, Grafana, and Alertmanager configuration
│   ├── prometheus/              # Prometheus config & exporters
│   └── grafana/                 # Grafana dashboards and values

├── terraform/                   # Infrastructure as Code (IaC) using Terraform
│   ├── main.tf                  # Root configuration entrypoint
│   ├── variables.tf             # Input variables for the deployment
│   ├── outputs.tf               # Output values from the infra
│   └── modules/                 # Reusable infra modules
│       ├── vpc/                 # VPC & Subnets
│       ├── eks-cluster/         # EKS control plane resources
│       └── node-group/          # Worker node group configuration
```

---

## 📊 Project Section-wise Overview

### ✅ Section 1: Microservices & Docker Containerization

* Each service (auth, cart, frontend, payments, product) containerized using Docker.
* Multi-language microservices (Node.js, Python, Go) share a consistent build structure.
* Docker Compose used locally for development and testing before Kubernetes deployment.

![Screenshot 2025-06-16 115725](https://github.com/user-attachments/assets/2e178528-d58f-47f5-9ab4-d11ae9e50467)

### ✅ Section 2: Kubernetes Deployment (YAML-based)

* Used Kubernetes manifests with `base-overlay` structure for multi-environment support (dev/staging/prod).
* Defined Deployment, Service, ConfigMap, Secret, Ingress, and HPA YAMLs for each service.
* Kustomize overlays allow environment-specific changes like replica count, secrets, and resources.

![Screenshot 2025-06-21 003009](https://github.com/user-attachments/assets/82ef680a-7ac5-427f-83af-d5d11aa5aad6)


### ✅ Section 3: GitOps Workflow with ArgoCD

* ArgoCD syncs Kubernetes state from GitHub repository (`argocd-example-apps`).
* Deployed as a Kubernetes service with its own namespace.
* Used App of Apps pattern for managing multiple microservices via a parent ArgoCD Application.
* Supports automated syncing, rollback, and health checks.

![Screenshot 2025-06-23 232810](https://github.com/user-attachments/assets/5f8fdf14-fdb6-4e2b-a32d-e36ddb7f0f7e)


### ✅ Section 4: CI/CD Pipelines with GitHub Actions & Jenkins

* GitHub Actions used for:

  * Linting, Unit Testing, Docker Image Builds, Pushing to Docker Hub
  * Kustomize validation for overlays
* Jenkins pipelines used for production-level multistage deployment jobs.
* Dockerized Jenkins with shared volumes and AWS credentials.
* CI triggers automated CD via `kubectl apply` and ArgoCD webhook.

![Screenshot 2025-06-23 204330](https://github.com/user-attachments/assets/581aa40c-c985-479d-a57d-7d9960a4c5b2)

### ✅ Section 5: Production-Grade Infrastructure using Terraform

* Created full AWS setup using modular Terraform structure (`vpc`, `eks-cluster`, `node-group`).
* EKS cluster bootstrapped with proper networking, IAM roles, and node groups.
* Outputs like cluster endpoint, VPC IDs, and node role ARN are exposed for integration.
* Terraform benefits: idempotent infra, version-controlled, and reusable modules.

### ✅ Section 6: Monitoring & Observability

* Prometheus deployed to collect metrics from pods, nodes, and K8s API.
* Grafana configured to visualize metrics via custom dashboards.
* Prebuilt dashboards imported for: Node CPU/memory, Pod health, EKS workload metrics.
* Dashboards display HPA scaling activity, latency, memory pressure, etc.
* Port forwarding or Ingress used to access Grafana on port `3000`.

![Screenshot 2025-06-25 213625](https://github.com/user-attachments/assets/269cee59-9761-4647-a37e-99c1d4c9fcfe)


---

## 🌟 Highlights

| Feature                | Description                                        |
| ---------------------- | -------------------------------------------------- |
| **Language Diversity** | Node.js, Python, Go, Java used across services     |
| **Kubernetes-Native**  | Kustomize, Helm, Ingress, HPA, ConfigMaps, Secrets |
| **CI/CD Pipelines**    | GitHub Actions + Jenkins in action                 |
| **GitOps Ready**       | ArgoCD App of Apps + Declarative YAML              |
| **Fully Monitored**    | Dashboards, Alerts, Logs                           |
| **Infra-as-Code**      | Complete Terraform setup for AWS EKS cluster       |

## Outputs


