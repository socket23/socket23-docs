.PHONY: help install build serve clean deploy docker-build docker-push test lint format

# Variables
PYTHON := python3
PIP := $(PYTHON) -m pip
MKDOCS := mkdocs
IMAGE_NAME := socket23/mkdocs
VERSION := latest
PLATFORMS := linux/arm/v7,linux/arm64,linux/amd64

# Colors for output
BLUE := \033[0;34m
GREEN := \033[0;32m
YELLOW := \033[1;33m
NC := \033[0m # No Color

help: ## Show this help message
	@echo "$(GREEN)Socket23 MkDocs - Available Commands$(NC)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(BLUE)%-20s$(NC) %s\n", $$1, $$2}'
	@echo ""

install: ## Install Python dependencies
	@echo "$(YELLOW)Installing dependencies...$(NC)"
	$(PIP) install --upgrade pip
	$(PIP) install -r requirements.txt
	@echo "$(GREEN)✓ Dependencies installed$(NC)"

build: ## Build the documentation site
	@echo "$(YELLOW)Building documentation...$(NC)"
	$(MKDOCS) build --strict
	@echo "$(GREEN)✓ Documentation built successfully$(NC)"

serve: ## Start local development server
	@echo "$(YELLOW)Starting development server...$(NC)"
	@echo "$(BLUE)Open http://localhost:8000 in your browser$(NC)"
	$(MKDOCS) serve

clean: ## Clean build artifacts
	@echo "$(YELLOW)Cleaning build artifacts...$(NC)"
	rm -rf site/
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@echo "$(GREEN)✓ Cleaned$(NC)"

test: ## Run tests and validation
	@echo "$(YELLOW)Running tests...$(NC)"
	$(MKDOCS) build --strict
	@echo "$(GREEN)✓ Tests passed$(NC)"

lint: ## Lint markdown files
	@echo "$(YELLOW)Linting markdown files...$(NC)"
	@command -v markdownlint >/dev/null 2>&1 || { echo "markdownlint not installed. Install with: npm install -g markdownlint-cli"; exit 1; }
	markdownlint docs/ README.md || true
	@echo "$(GREEN)✓ Linting complete$(NC)"

format: ## Format markdown files
	@echo "$(YELLOW)Formatting markdown files...$(NC)"
	@command -v prettier >/dev/null 2>&1 || { echo "prettier not installed. Install with: npm install -g prettier"; exit 1; }
	prettier --write "docs/**/*.md" README.md || true
	@echo "$(GREEN)✓ Formatting complete$(NC)"

docker-build: ## Build Docker image (local only)
	@echo "$(YELLOW)Building Docker image...$(NC)"
	./build.sh
	@echo "$(GREEN)✓ Docker image built$(NC)"

docker-build-push: ## Build and push Docker image to registry
	@echo "$(YELLOW)Building and pushing Docker image...$(NC)"
	PUSH=true ./build.sh
	@echo "$(GREEN)✓ Docker image built and pushed$(NC)"

docker-run: ## Run Docker container locally
	@echo "$(YELLOW)Running Docker container...$(NC)"
	docker run -p 8000:8000 --rm $(IMAGE_NAME):$(VERSION)

docker-stop: ## Stop running Docker containers
	@echo "$(YELLOW)Stopping Docker containers...$(NC)"
	docker ps -q --filter ancestor=$(IMAGE_NAME):$(VERSION) | xargs -r docker stop
	@echo "$(GREEN)✓ Containers stopped$(NC)"

deploy-stack: ## Deploy to Docker Swarm
	@echo "$(YELLOW)Deploying to Docker Swarm...$(NC)"
	docker stack deploy -c docker-compose.yml socket23-docs
	@echo "$(GREEN)✓ Deployed to Swarm$(NC)"

deploy-update: ## Update running Docker Swarm service
	@echo "$(YELLOW)Updating Swarm service...$(NC)"
	docker service update --force socket23-docs_mkdocs
	@echo "$(GREEN)✓ Service updated$(NC)"

deploy-logs: ## View Docker Swarm service logs
	docker service logs -f socket23-docs_mkdocs

deploy-status: ## Check Docker Swarm service status
	@echo "$(BLUE)Service Status:$(NC)"
	docker service ls | grep socket23-docs || echo "No services found"
	@echo ""
	@echo "$(BLUE)Service Details:$(NC)"
	docker service ps socket23-docs_mkdocs || echo "Service not running"

deploy-remove: ## Remove Docker Swarm stack
	@echo "$(YELLOW)Removing Swarm stack...$(NC)"
	docker stack rm socket23-docs
	@echo "$(GREEN)✓ Stack removed$(NC)"

dev: install serve ## Install dependencies and start development server

all: clean install build ## Clean, install, and build

.DEFAULT_GOAL := help

