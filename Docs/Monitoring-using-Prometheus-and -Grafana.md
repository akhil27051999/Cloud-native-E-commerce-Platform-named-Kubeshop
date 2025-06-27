# 📊 Section - 7: Monitoring and Observability - Kube-Shop

This section outlines how monitoring and observability is implemented in the Kube-Shop project using **Prometheus**, **Alertmanager**, **Grafana**, and exporters like **Node Exporter** and **Kube State Metrics**. Dashboards and alerting configurations provide deep insights into application and cluster health.

---

## 📁 Folder Structure

```
monitoring/
├── grafana/
│   ├── dashboards/
│   │   ├── custom-kube-shop-dashboard.json
│   │   ├── node-dashboard.json
│   │   └── pod-dashboard.json
│   └── grafana-values.yaml
├── prometheus/
│   ├── exporters/
│   │   ├── kube-state-metrics-values.yaml
│   │   └── node-exporter-values.yaml
│   ├── alertmanager-config.yaml
│   ├── prometheus-config.yaml
│   └── prometheus-values.yaml
```

---

## 📦 Prometheus Stack

We use the **kube-prometheus-stack** Helm chart which bundles the following:

* **Prometheus**: Collects metrics from Kubernetes objects and applications.
* **Alertmanager**: Sends alert notifications based on rules.
* **Node Exporter**: Provides host-level metrics.
* **Kube State Metrics**: Reports on Kubernetes object states.

### 🔧 Configuration Files

* `prometheus-values.yaml`: Custom values for Helm installation.
* `prometheus-config.yaml`: Prometheus scrape configurations.
* `alertmanager-config.yaml`: Routing and receiver setup (email, Slack).

### 📦 Exporters

Located under `exporters/`, these files configure Helm chart values for:

* **Node Exporter** (`node-exporter-values.yaml`)
* **Kube State Metrics** (`kube-state-metrics-values.yaml`)

### 🚀 Installation Commands

```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm install monitoring prometheus-community/kube-prometheus-stack \
  -f prometheus/prometheus-values.yaml
```

---

## 📈 Grafana

Grafana is used for visualizing the metrics scraped by Prometheus.

### 🗂 Dashboards

Dashboards are located in `grafana/dashboards/` and are auto-loaded using `grafana-values.yaml`.

* `node-dashboard.json`: Node resource metrics (CPU, memory, disk).
* `pod-dashboard.json`: Pod-level metrics (restarts, CPU/mem usage).
* `custom-kube-shop-dashboard.json`: Service-specific metrics for the Kube-Shop app.

### ⚙️ Configuration

* `grafana-values.yaml`: Preconfigures datasources and dashboard provisioning.

### 🚀 Installation

```bash
helm repo add grafana https://grafana.github.io/helm-charts
helm install grafana grafana/grafana \
  -f grafana/grafana-values.yaml
```

---

## 🛎️ Alerting

* **Alertmanager** is integrated with the Prometheus stack.
* Routing rules and contact points are managed in `alertmanager-config.yaml`
* Alerts can be sent via:

  * Email
  * Slack
  * Webhooks (e.g., OpsGenie, PagerDuty)

---

## ✅ Monitoring Outcomes

| Tool               | Purpose                                |
| ------------------ | -------------------------------------- |
| Prometheus         | Collects metrics from cluster & apps   |
| Alertmanager       | Sends alerts based on Prometheus rules |
| Grafana            | Visualizes metrics and logs            |
| Node Exporter      | Exposes host-level system metrics      |
| Kube State Metrics | Provides Kubernetes object states      |

---

## 📌 Best Practices

* Always provision monitoring stack **after** core Kubernetes components.
* Use **persistent volumes** for Grafana and Prometheus where required.
* Regularly back up custom dashboards.
* Secure access to Grafana with authentication plugins or OIDC.

## Outputs

### Prometheus Collecting Metrics from Cluster and Applications
![Screenshot 2025-06-26 002050](https://github.com/user-attachments/assets/77168a96-e355-45e2-a25b-163c75cc8035)

### Grafana uses Prometheus Metrics as Data source for Dashboards
![Screenshot 2025-06-26 004920](https://github.com/user-attachments/assets/ddb8c67c-818b-4db0-b2d5-88be7c8be19e)


### Grafana Dashboard for Node Exporter
![Screenshot 2025-06-25 213625](https://github.com/user-attachments/assets/ca642b5d-70ba-4172-a06c-7f002a4ac81b)

