#!/usr/bin/env bash
set -euo pipefail

# Use current directory as root
ROOT="./"

# Check if the main structure already exists
if [ -d "$ROOT/environments" ] || [ -d "$ROOT/platforms" ]; then
  echo "⚠️  Terraform structure already exists in this directory. Skipping bootstrap."
  exit 0
fi

echo "📂 Creating Terraform repo structure in current directory..."

# ---------------------------
# Root-level files
# ---------------------------
touch $ROOT/{README.md}

# ---------------------------
# Environments
# ---------------------------
for env in dev staging prod; do
  ENV_DIR="$ROOT/environments/$env"
  mkdir -p "$ENV_DIR"
  touch "$ENV_DIR"/{backend.tf,providers.tf,variables.tf,terraform.tfvars}

  # placeholder main.tf
  cat > "$ENV_DIR/main.tf" <<EOF
# Main Terraform configuration for $env environment
EOF
done

# ---------------------------
# Platforms and modules
# ---------------------------
# GitHub modules
mkdir -p $ROOT/platforms/github/modules/{repo,team,org} $ROOT/platforms/github/examples
for mod in repo team org; do
  MOD_DIR="$ROOT/platforms/github/modules/$mod"
  touch "$MOD_DIR"/{main.tf,variables.tf,outputs.tf}
done

# Discord modules
mkdir -p $ROOT/platforms/discord/modules/{server,channel,role} $ROOT/platforms/discord/examples
for mod in server channel role; do
  MOD_DIR="$ROOT/platforms/discord/modules/$mod"
  touch "$MOD_DIR"/{main.tf,variables.tf,outputs.tf}
done

# Common modules
mkdir -p $ROOT/platforms/common/tags
touch $ROOT/platforms/common/tags/{main.tf,variables.tf,outputs.tf}

# ---------------------------
# Scripts folder
# ---------------------------
mkdir -p $ROOT/scripts
# Create placeholder scripts
for script in init.sh plan.sh apply.sh; do
  SCRIPT_FILE="$ROOT/scripts/$script"
  cat > "$SCRIPT_FILE" <<EOF
#!/usr/bin/env bash
set -euo pipefail

echo "⚡ Running $script..."
EOF
  chmod +x "$SCRIPT_FILE"
done

echo "✅ Terraform repo structure initialized in $ROOT"
