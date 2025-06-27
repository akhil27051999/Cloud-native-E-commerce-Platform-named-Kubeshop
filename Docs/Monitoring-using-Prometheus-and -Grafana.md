# 📊 Section 7: Monitoring & Observability (Prometheus + Grafana)

To ensure high availability and performance visibility, the cluster is integrated with **Prometheus** for metrics collection and **Grafana** for visualization. Monitoring enables alerting, diagnostics, and SRE-level observability for microservices in Kubernetes.

### 📁 Folder Structure

```
monitoring/
├── prometheus/
│   ├── prometheus-deployment.yaml
│   ├── prometheus-service.yaml
│   └── prometheus-configmap.yaml
├── grafana/
│   ├── grafana-deployment.yaml
│   ├── grafana-service.yaml
│   ├── dashboards/
│   │   └── default.json
│   └── datasource-config.yaml
```

### 🔧 Prometheus Setup

| File                         | Purpose                                          |
| ---------------------------- | ------------------------------------------------ |
| `prometheus-deployment.yaml` | Deploys Prometheus server pod                    |
| `prometheus-service.yaml`    | Exposes Prometheus via ClusterIP or NodePort     |
| `prometheus-configmap.yaml`  | Defines scrape configs for Kubernetes components |

```yaml
# prometheus-configmap.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-config
  labels:
    name: prometheus-config

data:
  prometheus.yml: |
    global:
      scrape_interval: 15s
    scrape_configs:
      - job_name: 'kubernetes-nodes'
        kubernetes_sd_configs:
          - role: node
```

### 📈 Grafana Setup

| File                      | Purpose                                           |
| ------------------------- | ------------------------------------------------- |
| `grafana-deployment.yaml` | Deploys Grafana server with persistent dashboards |
| `datasource-config.yaml`  | Connects Grafana to Prometheus as the data source |
| `default.json`            | Sample dashboard for Kubernetes metrics           |

```yaml
# datasource-config.yaml
apiVersion: 1
datasources:
  - name: Prometheus
    type: prometheus
    url: http://prometheus-service:9090
    access: proxy
    isDefault: true
```

### 📊 Dashboards (Key Visuals)

* Kubernetes Pod CPU & Memory usage
* Node health and availability
* Microservice response latency
* EKS cluster performance
* HPA trigger status and scale-up/down behavior

### ⚙️ How to Deploy Monitoring Stack

```bash
# Apply Prometheus
kubectl apply -f monitoring/prometheus/

# Apply Grafana
kubectl apply -f monitoring/grafana/

# Port Forward Grafana for local access
kubectl port-forward svc/grafana 3000:3000
```

### ✅ Benefits

| Feature         | Value Provided                                                       |
| --------------- | -------------------------------------------------------------------- |
| Alerting        | Use Alertmanager with Prometheus for Slack/email notifications       |
| Visualization   | Real-time dashboards using Grafana                                   |
| Troubleshooting | Inspect pod-level and cluster-level metrics                          |
| DevOps Insight  | Helps in tuning HPA, scaling behavior, and understanding bottlenecks |
