#!/usr/bin/env bash
set -euo pipefail

# Load environment variables from .env
if [[ -f ".env" ]]; then
    export $(grep -v '^#' .env | xargs)
else
    echo "❌ .env file not found!"
    exit 1
fi

# Ensure ENVIRONMENT is set
if [[ -z "${ENVIRONMENT:-}" ]]; then
    echo "❌ ENVIRONMENT variable not set in .env"
    exit 1
fi

ENV_DIR="environments/$ENVIRONMENT"

# Check if the environment directory exists
if [[ ! -d "$ENV_DIR" ]]; then
    echo "❌ Environment directory '$ENV_DIR' does not exist!"
    exit 1
fi

echo "⚡ Planning Terraform in environment: $ENVIRONMENT"
cd "$ENV_DIR"

terraform plan
