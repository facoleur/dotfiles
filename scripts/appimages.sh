#!/bin/bash
set -e

source "$DOTFILES_DIR/scripts/style.sh"

BIN_DIR="$HOME/.local/bin"
DESKTOP_DIR="$HOME/.local/share/applications"
APPIMAGES_FILE="$DOTFILES_DIR/appimages.txt"

if [ ! -f "$APPIMAGES_FILE" ]; then
  printf "  %-22s ${YELLOW}%s${RESET}\n" "Status" "appimages.txt not found, skipping"
  exit 0
fi

appimage_count=$(grep -cv '^\s*#\|^\s*$' "$APPIMAGES_FILE" 2>/dev/null || echo "unknown")

label "AppImages list" "$APPIMAGES_FILE"
label "AppImages found" "$appimage_count"
label "Install dir" "$BIN_DIR"
echo ""

mkdir -p "$BIN_DIR" "$DESKTOP_DIR"

install_appimage() {
  local id="$1" name="$2" url="$3" categories="${4:-Utility}"
  local bin="$BIN_DIR/$id.AppImage"

  info "Installing $name..."
  curl -L --progress-bar "$url" -o "$bin"
  chmod +x "$bin"

  cat > "$DESKTOP_DIR/$id.desktop" <<EOF
[Desktop Entry]
Name=$name
Exec=$bin
Icon=$id
Type=Application
Categories=$categories
Terminal=false
EOF
}

while IFS='|' read -r id name url categories; do
  [[ "$id" =~ ^#.*$ || -z "$id" ]] && continue
  install_appimage "$id" "$name" "$url" "$categories"
done < "$APPIMAGES_FILE"

echo ""
printf "  ${GREEN}All AppImages installed successfully.${RESET}\n"
