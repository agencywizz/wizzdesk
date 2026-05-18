#!/usr/bin/env bash
# VPS first-time setup script
# Run once on the server to clone WizzDesk and prepare for auto-deploy

set -e

REPO_URL="git@github.com:agencywizz/wizzdesk.git"
INSTALL_DIR="${1:-/opt/wizzdesk}"

echo "🚀 Cloning WizzDesk into $INSTALL_DIR..."
git clone --recurse-submodules --branch wizz "$REPO_URL" "$INSTALL_DIR"
cd "$INSTALL_DIR"

echo "⚙️  Setting up environment..."
if [ ! -f .env ]; then
  cp .env.example .env
  echo "📝 .env criado — edita com as tuas variáveis antes de subir o stack"
fi

echo ""
echo "✅ Setup completo!"
echo ""
echo "Próximos passos:"
echo "  1. Edita o .env: nano $INSTALL_DIR/.env"
echo "  2. Faz o build das imagens: cd $INSTALL_DIR && bash build-images.sh"
echo "  3. Sobe o stack: docker stack deploy -c docker-stack.yml wizzdesk"
echo "  4. Seed (primeira vez): bash seed.sh"
echo ""
echo "Depois configura os GitHub Secrets (Settings → Secrets → Actions):"
echo "  VPS_HOST         = IP ou domínio do servidor"
echo "  VPS_USER         = utilizador SSH (ex: root ou deploy)"
echo "  VPS_SSH_KEY      = chave privada SSH (cat ~/.ssh/id_rsa)"
echo "  VPS_PROJECT_PATH = $INSTALL_DIR"
echo "  VPS_PORT         = 22 (opcional)"
