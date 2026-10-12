# dotfiles

Dotfiles gérés par [chezmoi](https://chezmoi.io), avec deux profils dérivés
automatiquement de l'OS détecté.

## Installation sur une machine neuve

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply facoleur
```

C'est tout. Le profil est choisi seul :

| OS détecté (`/etc/os-release`) | Profil | Ce qui est posé |
|---|---|---|
| `arch` | **desktop** | tout : Hyprland, waybar, walker, kitty, thème Omarchy, AppImages |
| tout le reste (debian, ubuntu…) | **server** | socle seulement : fish, tmux, starship, git, gh, zoxide, docker, caddy, Claude Code |

Pour forcer le profil server sur une machine Arch (test, conteneur) :

```sh
DOTFILES_PROFILE=server chezmoi init --apply facoleur
```

## Après l'installation

Ce qui n'est pas automatisable (secrets, état propre à la machine) :

```sh
gh auth login                      # ~/.config/gh/hosts.yml n'est pas versionné
gpg --import <ta-cle>              # desktop : les commits sont signés
omarchy-theme-set tokyo-night      # desktop : réapplique le thème
sudoedit /etc/caddy/Caddyfile      # server : propre à chaque VPS
```

## Usage quotidien

```sh
chezmoi edit --apply ~/.config/fish/config.fish   # éditer la source puis appliquer
chezmoi re-add                                    # récupérer les modifs faites en direct
chezmoi diff                                      # ce qui changerait
chezmoi cd && git push                             # publier
```

⚠️ chezmoi **copie** les fichiers, il ne crée pas de symlinks : une modification
faite directement dans `~/.config` doit être reprise avec `chezmoi re-add`,
sinon elle sera écrasée au prochain `apply`.

## Arborescence

```txt
.
├── .chezmoi.toml.tmpl      # détecte l'OS -> .profile (desktop|server)
├── .chezmoiignore          # LA séparation desktop/server
├── .chezmoiscripts/
│   ├── run_onchange_before_10-packages.sh.tmpl   # yay (arch) vs apt (debian)
│   ├── run_onchange_after_20-tools.sh.tmpl       # starship, claude, uv, fisher, docker, caddy
│   ├── run_once_after_30-shell.sh.tmpl           # chsh -s fish
│   └── run_onchange_after_40-appimages.sh.tmpl   # desktop : AppImages + entrées de menu
├── packages-arch.txt       # paquets yay, desktop
├── packages-apt.txt        # paquets apt, server (strict minimum)
├── appimages.txt           # id|name|url|categories
├── dot_config/             # -> ~/.config
├── dot_claude/             # -> ~/.claude (settings.json + CLAUDE.md seulement)
└── dot_bashrc, dot_profile, …
```

## Ce qui n'est volontairement pas versionné

- **Secrets** : `gh/hosts.yml`, `fish/fish_variables`.
- **Défauts Omarchy jamais modifiés** : nvim, mako, swayosd, fastfetch, imv,
  wiremix, btop, lazygit, lazydocker, mise, atuin — Omarchy les gère, les
  versionner créerait un conflit à chaque mise à jour.
- **État applicatif** : `Soundux/config.json`, `omarchy/current/`.
- **Généré par les installeurs** : `fish/conf.d/`, `fish/completions/`, et les
  fonctions fish posées par fisher (`fisher.fish`, `bass.fish`).
