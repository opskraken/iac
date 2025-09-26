# =====================================================================
#  Terraform Infrastructure as Code — Makefile
# =====================================================================
# Usage:
#   make <target> ENV=dev|staging|prod
#
# Default ENV is "dev".
# =====================================================================

# Environment
ENV ?= dev
ENV_DIR := environments/$(ENV)

# Terraform binary
TF ?= terraform

# Common options
TF_OPTS = -chdir=$(ENV_DIR)

# =====================================================================
# Targets
# =====================================================================

.PHONY: help init-structure destroy-structure init plan apply destroy fmt validate lint clean wipe-state all

help: ## Show this help message
	@echo
	@echo "📖 Terraform Infrastructure as Code — Makefile"
	@echo
	@echo "Usage:"
	@echo "  make <target> ENV=dev|staging|prod"
	@echo
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "  \033[36m%-18s\033[0m %s\n", $$1, $$2}'
	@echo
	@echo "Environment:"
	@echo "  ENV (default: dev) — choose which environment to work on."
	@echo
	@echo "Examples:"
	@echo "  make init-structure         # Bootstrap repo structure"
	@echo "  make destroy-structure      # Destroy all resources and remove repo"
	@echo "  make init           		 # Initialize terraform in environment set in .env"
	@echo "  make plan       		     # Show plan for terraform in environment set in .env"
	@echo "  make Apply			         # Apply changes to terraform in environment set in .env"
	@echo "  make wipe-state			 # Wipe Terraform state for selected ENV"
	@echo "  make fmt                    # Format all Terraform code"
	@echo

# ---------------------------------------------------------------------
# Bootstrap repo structure (runs only if not exists)
# ---------------------------------------------------------------------
init-structure: ## Bootstrap Terraform repo structure (only runs if not exists)
	@if [ -d "infra-as-code" ]; then \
		echo "⚠️  Directory 'infra-as-code' already exists. Skipping bootstrap."; \
	else \
		echo "📂 Initializing Terraform repo structure..."; \
		chmod +x ./scripts/init_structure.sh; \
		if command -v dos2unix >/dev/null 2>&1; then \
			dos2unix ./scripts/init_structure.sh; \
		fi; \
		./scripts/init_structure.sh; \
	fi

# ---------------------------------------------------------------------
# Destroy repo structure and all Terraform resources
# ---------------------------------------------------------------------
destroy-structure: ## Destroy all Terraform resources and remove repo
	@if [ ! -d "." ]; then \
		echo "⚠️  Directory '.' does not exist. Nothing to destroy."; \
	else \
		echo "🛑 Destroying all Terraform resources in all environments..."; \
		for env in dev staging prod; do \
			ENV_DIR="./environments/$$env"; \
			if [ -d "$$ENV_DIR" ]; then \
				echo "🔹 Destroying $$env environment..."; \
				terraform -chdir="$$ENV_DIR" destroy -auto-approve || true; \
			fi; \
		done; \
		echo "🗑 Removing all initialized files..."; \
		rm -rf ./environments ./platforms versions.tf providers.tf variables.tf outputs.tf terraform.tfvars; \
		echo "✅ All resources destroyed and directory cleaned."; \
	fi

# ---------------------------------------------------------------------
# Terraform commands with safe executable prep
# ---------------------------------------------------------------------
init: ## Initialize Terraform (downloads providers, sets up backend)
	@chmod +x ./scripts/init.sh; \
	if command -v dos2unix >/dev/null 2>&1; then dos2unix ./scripts/init.sh; fi; \
	./scripts/init.sh

plan: ## Show execution plan for selected ENV
	@chmod +x ./scripts/plan.sh; \
	if command -v dos2unix >/dev/null 2>&1; then dos2unix ./scripts/plan.sh; fi; \
	./scripts/plan.sh

apply: ## Apply changes for selected ENV
	@chmod +x ./scripts/apply.sh; \
	if command -v dos2unix >/dev/null 2>&1; then dos2unix ./scripts/apply.sh; fi; \
	./scripts/apply.sh

destroy: ## Destroy all resources for selected ENV (⚠️ dangerous)
	$(TF) $(TF_OPTS) destroy -auto-approve

# ---------------------------------------------------------------------
# Wipe Terraform state files
# ---------------------------------------------------------------------
wipe-state: ## Wipe Terraform state files for selected ENV
	@chmod +x ./scripts/wipe_state.sh; \
	if command -v dos2unix >/dev/null 2>&1; then dos2unix ./scripts/wipe_state.sh; fi; \
	./scripts/wipe_state.sh

fmt: ## Format Terraform code
	$(TF) fmt -recursive

validate: ## Validate Terraform configuration
	$(TF) $(TF_OPTS) validate

lint: ## Run tflint (if installed)
	tflint $(ENV_DIR) || true

clean: ## Remove local Terraform state/plan files
	rm -f $(ENV_DIR)/terraform.tfstate* $(ENV_DIR)/.terraform.lock.hcl $(ENV_DIR)/tfplan
	rm -rf $(ENV_DIR)/.terraform

all: fmt validate plan ## Run fmt, validate, then plan for selected ENV
