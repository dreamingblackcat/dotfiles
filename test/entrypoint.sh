#!/usr/bin/env bash
set -e

# Colors
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${CYAN}"
echo "╔══════════════════════════════════════════════════╗"
echo "║        dotfiles test environment (Ubuntu)        ║"
echo "╚══════════════════════════════════════════════════╝"
echo -e "${NC}"

echo -e "${GREEN}System Info:${NC}"
echo "  OS      : $(uname -s) $(uname -r)"
echo "  Arch    : $(uname -m)"
echo "  User    : $(whoami)"
echo "  Home    : $HOME"
echo ""

# Fix permissions on mounted dotfiles directory
if [ -d "/home/chan/dotfiles" ]; then
    sudo chown -R chan:chan /home/chan/dotfiles
fi
echo ""

echo -e "${YELLOW}Quick Start:${NC}"
echo ""
echo "  Test with LOCAL repo (mounted at /home/chan/dotfiles):"
echo "    chezmoi init --apply --source=/home/chan/dotfiles"
echo ""
echo "  Test pulling from GitHub:"
echo "    chezmoi init --apply github.com/dreamingblackcat/dotfiles"
echo ""
echo "  Run automated verification:"
echo "    bash /home/chan/dotfiles/test/test-chezmoi.sh"
echo ""
echo "  Note: chezmoi will prompt for your name, email, and whether"
echo "  this is a work machine. Answer the prompts to continue."
echo ""
echo "────────────────────────────────────────────────────"
echo ""

exec bash
