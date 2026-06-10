#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"
export DOTFILES_DIR

source "$DOTFILES_DIR/scripts/style.sh"

step=1
run_step() {
  local name="$1"
  local script="$2"
  echo ""
  printf "%s\n" "$SEP"
  printf "  ${BOLD}Step %d  ${RESET}%s\n" "$step" "$name"
  printf "%s\n" "$SEP"
  echo ""
  if [ -f "$script" ]; then
    bash "$script"
  else
    printf "  %-22s ${YELLOW}%s${RESET}\n" "Status" "script not found, skipping"
  fi
  step=$((step + 1))
}

echo ""
printf "%s\n" "$BANNER"
printf "           ${BOLD}Omarchy Bootstrapper${RESET}\n"
printf "%s\n" "$BANNER"
echo ""
label "Working directory" "$DOTFILES_DIR"
echo ""

run_step "Packages"  "$DOTFILES_DIR/scripts/packages.sh"
run_step "Dotfiles"  "$DOTFILES_DIR/scripts/dotfiles.sh"
run_step "AppImages" "$DOTFILES_DIR/scripts/appimages.sh"

echo ""
printf "%s\n" "$BANNER"
printf "           ${GREEN}${BOLD}Bootstrap complete${RESET}\n"
printf "%s\n" "$BANNER"
echo ""
