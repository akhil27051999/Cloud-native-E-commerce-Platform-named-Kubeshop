# 🔧 Section 1: Microservices & Docker Containerization

This section covers all five microservices used in the `kube-shop` e-commerce platform. Each service is independently developed and containerized using Docker, following best practices for isolation, scalability, and portability.

## 🌐 1. Frontend Microservice (Node.js)

**Purpose**: Provides the user interface for customers to browse products, view cart, login, and checkout.

**Why Node.js?**
Node.js is ideal for handling asynchronous user interactions and API calls with high efficiency and low resource usage.

#### 📦 Key Files

| File           | Description                             |
| -------------- | --------------------------------------- |
| `index.js`     | Main entry point of the application     |
| `package.json` | Lists dependencies and scripts          |
| `Dockerfile`   | Instructions to build a container image |

#### 🐳 Dockerfile

```Dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package.json ./
RUN npm install
COPY index.js ./
CMD ["node", "index.js"]

```

✅ **Result**: Runs a minimal, production-ready Node.js app using Alpine base image.

## 🛒 2. Cart Microservice (Node.js)

**Purpose**: Enables cart operations such as adding, removing, and updating products in a customer's cart.

**Why Node.js?**
Node.js handles concurrent requests efficiently and is well-suited for stateless RESTful APIs.

**Architecture**: Stateless microservice using Express.js.

#### 🐳 Dockerfile

Same as frontend for simplicity:

```Dockerfile
FROM node:18-alpine
WORKDIR /app
COPY package.json ./
RUN npm install
COPY index.js ./
CMD ["node", "index.js"]

```

✅ **Result**: A fast and lightweight microservice ideal for short-lived request-response operations.


## 🔐 3. Auth Microservice (Python - Flask)

**Purpose**: Manages secure user authentication with JWT support.

**Why Flask?**
Flask is lightweight, flexible, and efficient for developing secure REST APIs quickly.

#### 🔐 JWT Authentication Flow

1. User submits login credentials
2. Server validates credentials and issues a JWT
3. JWT is used for subsequent requests to other services

#### 🐳 Dockerfile

```Dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY app.py .
RUN pip install flask
EXPOSE 8080
CMD ["python", "app.py"]

```

✅ **Result**: A secure authentication service with token-based login support.

## 💳 4. Payments Microservice (Go)

**Purpose**: Simulates payment operations for order checkout flow.

**Why Go?**
Go (Golang) offers concurrency, fast execution, and is ideal for I/O bound microservices.

#### 💡 Highlights

* Performs mock payment validation
* Can be extended to integrate with real payment APIs like Stripe or Razorpay

#### 🐳 Multi-Stage Dockerfile

```Dockerfile
FROM golang:1.20-alpine

WORKDIR /app
COPY go.mod ./
COPY main.go ./

RUN go build -o payments main.go
CMD ["./payments"]

```

✅ **Result**: A production-optimized image (\~15MB) with no Go runtime required.


## 🛍️ 5. Product Microservice (Python - Flask)

*Purpose**: Offers CRUD APIs for managing product catalog and categories.

**Why Spring Boot?**
Spring Boot provides built-in REST support, scalability, and enterprise features like security and validation.

#### 🐳 Dockerfile

```Dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY app.py .
RUN pip install flask
EXPOSE 8080
CMD ["python", "app.py"]

```

✅ **Result**: A stable, production-grade microservice running as a standalone Spring Boot JAR.

---

### 🛠️ Containerization Strategy Summary

| Step  | Description                                                            |
| ----- | ---------------------------------------------------------------------- |
| Build | Dockerfile per service builds application with language-specific tools |
| Tag   | Docker images tagged with service name/version                         |
| Push  | Images pushed to Docker Hub or AWS ECR                                 |
| Run   | Containers deployed to Kubernetes via manifests or Helm charts         |

#### ✅ Docker Best Practices Used

* Base images are minimal (Alpine, slim)
* Multi-stage builds for Go and Java
* Clear separation of build and runtime stages
* Expose only required ports

---

### 💡 Why Containerize Each Microservice?

| Benefit         | Description                                              |
| --------------- | -------------------------------------------------------- |
| Isolation       | Each service runs independently — no shared state        |
| Portability     | Same container runs on local, dev, staging, and prod     |
| CI/CD Friendly  | Works seamlessly with GitHub Actions, Jenkins, or ArgoCD |
| Scalability     | Scale each service independently based on load           |
| Fault Tolerance | Failures in one service do not impact others             |

---

### 🧪 Local Docker Testing Instructions

```bash
# Navigate into a microservice
cd microservices/cart

# Build the Docker image
docker build -t cart-service .

# Run the service locally
docker run -p 3000:3000 cart-service
```

Repeat this for each microservice using their respective ports and Dockerfiles.

## Outputs

### Images Pushed to DockerHub
![Screenshot 2025-06-16 115725](https://github.com/user-attachments/assets/0710d02b-8b01-4387-8718-a75926d184c9)

### Frontend Testing using Port-forwarding
![Screenshot 2025-06-17 011000](https://github.com/user-attachments/assets/bffb1fab-498f-4034-9e7c-149196a3d00d)
