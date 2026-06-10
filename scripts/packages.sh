#!/bin/bash
set -e

source "$DOTFILES_DIR/scripts/style.sh"

PKG_FILE="$DOTFILES_DIR/packages.txt"
pkg_count=$(grep -c . "$PKG_FILE" 2>/dev/null || echo "unknown")

label "Package list" "$PKG_FILE"
label "Packages found" "$pkg_count"
echo ""
info "Installing packages via yay, this may take a while..."
echo ""

yay -S --needed --noconfirm - < "$PKG_FILE"

echo ""
printf "  ${GREEN}All packages installed successfully.${RESET}\n"
