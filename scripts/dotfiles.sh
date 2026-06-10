#!/bin/bash
set -e

source "$DOTFILES_DIR/scripts/style.sh"

# Ensure stow is available
if ! command -v stow &>/dev/null; then
  info "stow not found, installing..."
  yay -S --needed --noconfirm stow
  label "stow" "installed"
else
  label "stow" "already installed"
fi

BACKUP_DIR="$HOME/dotfiles/dotfiles_backup/dotfiles-backup-$(date +%Y%m%d-%H%M)"

echo ""
info "Checking for conflicts..."

if ! stow -n -d "$DOTFILES_DIR" -t "$HOME" home 2>/dev/null; then
  echo ""
  printf "  ${YELLOW}Conflicts detected. Backing up conflicting files before applying.${RESET}\n"
  label "Backup location" "$BACKUP_DIR"
  echo ""
  mkdir -p "$BACKUP_DIR"
  stow -d "$DOTFILES_DIR" -t "$HOME" home 2>&1 \
    | grep "existing target" \
    | awk '{print $NF}' \
    | while read -r f; do
        indent "$f"
        mv "$HOME/$f" "$BACKUP_DIR/" 2>/dev/null || true
      done
else
  info "No conflicts found."
fi

echo ""
info "Applying dotfiles with stow..."
stow --adopt -d "$DOTFILES_DIR" -t "$HOME" home

xdg-user-dirs-update

echo ""
printf "  ${GREEN}Dotfiles applied successfully.${RESET}\n"
