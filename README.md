# DevOps Flask Application 🚀

A complete DevOps project demonstrating containerization, orchestration, CI/CD, Infrastructure as Code, monitoring, and Kubernetes deployment.

---

# Technologies Used

- Python Flask
- Docker
- Docker Compose
- PostgreSQL
- NGINX
- GitHub Actions
- Kubernetes
- Minikube
- Prometheus
- Grafana
- Terraform
- Trivy Security Scanner

---

# Features

- Multi-container application
- Reverse proxy with NGINX
- PostgreSQL database integration
- Docker containerization
- CI/CD pipeline with GitHub Actions
- Kubernetes deployment
- Horizontal Pod Autoscaling
- Ingress Controller
- Monitoring with Prometheus & Grafana
- Security scanning with Trivy
- Infrastructure as Code using Terraform
- ConfigMaps and Secrets
- Liveness and Readiness Probes

---

# Project Architecture

User → Ingress → Flask App → PostgreSQL

Monitoring:
Prometheus → Grafana

Infrastructure:
Terraform → Docker Containers

---

# Run with Docker Compose

```bash
docker compose up -d

Run Kubernetes
kubectl apply -f k8s/

Terraform Infrastructure
cd terraform

terraform init
terraform plan
terraform apply
# if you want to destroy 
terraform destroy


Monitoring

Grafana Dashboard:
http://localhost:3000

Security Scan
trivy image devops-project-flask-app:latest