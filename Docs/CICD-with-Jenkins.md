# 🔄 Section 5: Continuous Integration & Continuous Deployment (CI/CD)

This section details how CI/CD pipelines were implemented using GitHub Actions and Jenkins.

### ⚙️ GitHub Actions (Optional Alternative)

Each microservice contains its own `.github/workflows/ci-cd.yaml` file that performs:

* Code linting and unit testing
* Docker image build and push to Docker Hub
* Deployment trigger via ArgoCD or `kubectl`

```yaml
# Sample Cart GitHub Action Pipeline
name: Deploy Cart Microservice

on:
  push:
    paths:
      - 'microservices/cart/**'
      - '.github/workflows/deploy-cart.yml'

jobs:
  build-push-deploy:
    runs-on: ubuntu-latest
    env:
      IMAGE_NAME: akhilthyadi/kube-cart
      KUSTOMIZE_DIR: k8s-manifests/base/cart

    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Set Image Tag
        run: echo "IMAGE_TAG=v${{ github.run_number }}" >> $GITHUB_ENV

      - name: Build Docker Image
        run: docker build -t $IMAGE_NAME:$IMAGE_TAG ./microservices/cart

      - name: Login to DockerHub
        run: echo "${{ secrets.DOCKERHUB_TOKEN }}" | docker login -u "${{ secrets.DOCKERHUB_USERNAME }}" --password-stdin

      - name: Push Docker Image
        run: docker push $IMAGE_NAME:$IMAGE_TAG

      - name: Install Kustomize
        run: |
          curl -s https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh | bash
          sudo mv kustomize /usr/local/bin/

      - name: Update Kustomization Image Tag
        working-directory: ${{ env.KUSTOMIZE_DIR }}
        run: kustomize edit set image $IMAGE_NAME=$IMAGE_NAME:$IMAGE_TAG

      - name: Commit & Push Changes
        run: |
          git config user.email "github-actions@github.com"
          git config user.name "GitHub Actions"
          git add $KUSTOMIZE_DIR/kustomization.yaml
          git commit -m "Update cart image to $IMAGE_TAG" || echo "No changes to commit"
          git push https://x-access-token:${{ secrets.GH_TOKEN }}@github.com/${{ github.repository }}.git HEAD:main

```

### 🔨 Jenkins Pipelines 

For teams preferring Jenkins, a `Jenkinsfile` can define similar steps:

```groovy
# Sample Cart pipeline in Jenkins
pipeline {
  agent any

  environment {
    IMAGE_NAME = "akhilthyadi/kube-cart"
    IMAGE_TAG = "v${env.BUILD_NUMBER}"
    KUSTOMIZE_DIR = "k8s-manifests/overlays/dev"
    CREDENTIALS_ID = 'dockerhub-creds'
    GIT_CREDENTIALS_ID = 'github-creds'
  }

  stages {
    stage('Checkout') {
      steps {
        git branch: 'main',
            url: 'https://github.com/akhil27051999/Cloud-native-E-commerce-Platform-named-kubeshop.git'
      }
    }

    stage('Build Image') {
      steps {
        sh "docker build -t ${IMAGE_NAME}:${IMAGE_TAG} ./microservices/cart"
      }
    }

    stage('Push Image') {
      steps {
        withCredentials([usernamePassword(
          credentialsId: "${CREDENTIALS_ID}",
          usernameVariable: 'DOCKER_USER',
          passwordVariable: 'DOCKER_PASS'
        )]) {
          sh '''
            echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
            docker push ${IMAGE_NAME}:${IMAGE_TAG}
          '''
        }
      }
    }

    stage('Update Kustomize') {
      steps {
        dir("${KUSTOMIZE_DIR}") {
          sh "kustomize edit set image ${IMAGE_NAME}=${IMAGE_NAME}:${IMAGE_TAG}"
        }

        sh '''
          git config user.email 'jenkins@example.com'
          git config user.name 'jenkins'
          git add ${KUSTOMIZE_DIR}/kustomization.yaml
          git commit -m "Update cart image to ${IMAGE_TAG}" || echo "No changes"
        '''

        withCredentials([usernamePassword(
          credentialsId: "${GIT_CREDENTIALS_ID}",
          usernameVariable: 'GIT_USER',
          passwordVariable: 'GIT_PASS'
        )]) {
          sh '''
            git remote set-url origin https://${GIT_USER}:${GIT_PASS}@github.com/akhil27051999/Cloud-native-E-commerce-Platform-named-kubeshop.git
            git push origin main
          '''
        }
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
