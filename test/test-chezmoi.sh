#!/usr/bin/env bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m'

PASS=0
FAIL=0

pass() { echo -e "${GREEN}✓ PASS${NC} $1"; ((PASS++)); }
fail() { echo -e "${RED}✗ FAIL${NC} $1"; ((FAIL++)); }

echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${CYAN}         dotfiles verification checks              ${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# CHECK 1: chezmoi installed
if command -v chezmoi &>/dev/null; then
    pass "chezmoi is installed ($(chezmoi --version 2>&1 | head -1))"
else
    fail "chezmoi is not installed"
    echo "  → Install it: sh -c \"\$(curl -fsLS get.chezmoi.io)\""
    echo ""
    echo "Cannot continue without chezmoi. Exiting."
    exit 1
fi

# CHECK 2: apply chezmoi if not yet applied
if [ ! -f "$HOME/.zshrc" ]; then
    echo "Dotfiles not yet applied. Applying now..."
    if [ -n "$CHEZMOI_SOURCE_DIR" ] && [ -d "$CHEZMOI_SOURCE_DIR" ]; then
        chezmoi init --apply --source="$CHEZMOI_SOURCE_DIR"
    else
        chezmoi init --apply "github.com/dreamingblackcat/dotfiles"
    fi
fi

# CHECK 3: key dotfiles exist
for f in "$HOME/.zshrc" "$HOME/.gitconfig" "$HOME/.tmux.conf" "$HOME/.p10k.zsh" "$HOME/.githelpers"; do
    if [ -f "$f" ]; then
        pass "$f exists"
    else
        fail "$f is missing"
    fi
done

# CHECK 4: nvim config
if [ -d "$HOME/.config/nvim" ]; then
    pass "~/.config/nvim/ directory exists"
else
    fail "~/.config/nvim/ directory is missing"
fi

# CHECK 5: SSH config permissions
if [ -f "$HOME/.ssh/config" ]; then
    perms=$(stat -c "%a" "$HOME/.ssh/config" 2>/dev/null || stat -f "%A" "$HOME/.ssh/config" 2>/dev/null)
    if [ "$perms" = "600" ]; then
        pass "~/.ssh/config has correct permissions (600)"
    else
        fail "~/.ssh/config has wrong permissions ($perms, expected 600)"
    fi
else
    fail "~/.ssh/config does not exist"
fi

# CHECK 6: zsh available
if command -v zsh &>/dev/null; then
    pass "zsh is available ($(zsh --version))"
else
    fail "zsh is not available"
fi

# Summary
echo ""
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "Results: ${GREEN}${PASS} passed${NC}  ${RED}${FAIL} failed${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

[ "$FAIL" -eq 0 ] && exit 0 || exit 1
