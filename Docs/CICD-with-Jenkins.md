# 🔄 Section 5: Continuous Integration & Continuous Deployment (CI/CD)

This section details how CI/CD pipelines were implemented using GitHub Actions and Jenkins.

### ⚙️ GitHub Actions

Each microservice contains its own `.github/workflows/ci-cd.yaml` file that performs:

* Code linting and unit testing
* Docker image build and push to Docker Hub
* Deployment trigger via ArgoCD or `kubectl`

```yaml
# Sample GitHub Actions Workflow
name: CI/CD Pipeline
on:
  push:
    branches: [ main ]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v3

      - name: Build Docker image
        run: docker build -t myapp:${{ github.sha }} .

      - name: Push to Docker Hub
        run: docker push myapp:${{ github.sha }}

      - name: Trigger ArgoCD Sync
        run: curl -X POST $ARGOCD_TRIGGER_WEBHOOK_URL
```

### 🔨 Jenkins Pipelines (Optional Alternative)

For teams preferring Jenkins, a `Jenkinsfile` can define similar steps:

```groovy
pipeline {
  agent any
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t myapp:${BUILD_ID} .'
      }
    }
    stage('Push') {
      steps {
        withCredentials([usernamePassword(...)]) {
          sh 'docker push myapp:${BUILD_ID}'
        }
      }
    }
    stage('Deploy') {
      steps {
        sh 'kubectl apply -k k8s-manifests/overlays/dev/'
      }
    }
  }
}
```

### ✅ CI/CD Outcome

| Stage        | Tool             | Action                            |
| ------------ | ---------------- | --------------------------------- |
| Build        | GitHub Actions   | Docker image built and tested     |
| Push         | Docker CLI       | Image pushed to Docker Hub or ECR |
| Deploy       | ArgoCD / kubectl | Application synced with cluster   |
| Notification | GitHub/Slack     | Pipeline result notified          |
