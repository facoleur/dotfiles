#!/bin/bash
# Finalisation de la migration chezmoi.
# A lancer toi-meme : commit signe (passphrase GPG) + force-push (destructif).
#
#   bash ~/.local/share/chezmoi/finalise-migration.sh
#
set -euo pipefail
cd "$HOME/.local/share/chezmoi"

echo "### 1/4  commit du nouveau layout (ta passphrase GPG va etre demandee)"
git add -A
git commit -F - <<'MSG'
feat: migration de GNU Stow vers chezmoi, profils desktop/server

Remplace le bootstrapper Omarchy (bootstrap.sh + stow + 4 scripts) par un
source state chezmoi, avec un profil derive automatiquement de /etc/os-release :
arch -> desktop (tout), le reste -> server (socle seulement).

Installation sur une machine neuve :
  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply facoleur

- .chezmoi.toml.tmpl  : detection d'OS, override par DOTFILES_PROFILE
- .chezmoiignore      : separation desktop/server
- .chezmoiscripts/    : paquets (yay|apt), outils hors depots, shell, AppImages
- templating          : chemins absolus -> .chezmoi.homeDir, gpgsign et
                        signingkey desktop uniquement (pas de cle GPG sur VPS)

Sorti du perimetre : configs orphelines (zellij, foot, ghostty, alacritty, zed),
defauts Omarchy jamais modifies, etat applicatif (Soundux), secrets
(gh/hosts.yml, fish_variables, .claude/settings.json).
MSG

echo
echo "### 2/4  purge du token OAuth de TOUT l'historique"
remote=$(git remote get-url origin)
uvx git-filter-repo --force --invert-paths \
  --path home/.config/zed \
  --path home/.config/fish/fish_variables
git remote add origin "$remote" 2>/dev/null || git remote set-url origin "$remote"
echo "verification (doit etre vide) :"
git log --all --oneline -- home/.config/zed | head -3 || true

echo
echo "### 3/4  renommage du repo GitHub en 'dotfiles'"
gh repo rename dotfiles --repo facoleur/omarchy-bootstrapper --yes
git remote set-url origin git@github.com:facoleur/dotfiles.git

echo
echo "### 4/4  force-push (reecrit l'historique distant)"
git push --force -u origin chezmoi:master

echo
echo "FAIT. Le one-liner est maintenant :"
echo '  sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply facoleur'
echo
echo "RESTE A FAIRE A LA MAIN, important :"
echo "  - REVOQUER le token OAuth ChatGPT/Codex expose (chatgpt.com -> parametres"
echo "    -> applications connectees, ou reconnecte Codex pour invalider l'ancien)"
