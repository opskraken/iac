#!/usr/bin/env bash
set -euo pipefail

ROOT="./"

if [ ! -d "$ROOT/environments" ]; then
    echo "⚠️  Directory '$ROOT/environments' does not exist. Nothing to destroy."
    exit 0
fi

echo "🛑 Destroying all Terraform resources in all environments..."

for env in dev staging prod; do
    ENV_DIR="$ROOT/environments/$env"
    if [ -d "$ENV_DIR" ]; then
        # Only run destroy if Terraform was initialized
        if [ -d "$ENV_DIR/.terraform" ]; then
            echo "🔹 Destroying $env environment..."
            terraform -chdir="$ENV_DIR" destroy -auto-approve || true
        else
            echo "⚠️  $env environment not initialized. Skipping destroy."
        fi
    fi
done

echo "🗑 Removing all initialized directories and files..."
rm -rf "$ROOT/environments" "$ROOT/platforms" "$ROOT"/{versions.tf,providers.tf,variables.tf,outputs.tf,terraform.tfvars}

echo "✅ All resources destroyed and directory cleaned."
