# Dotfiles — Context for Claude

## Système

Arch Linux + [Omarchy](https://omarchy.org/) (Hyprland, Waybar, Walker, Kitty, Fish, Mako).
Terminal : **Kitty** avec **Fish**. Font système : **JetBrains Mono Nerd Font**.

## Structure dotfiles

GNU Stow — `home/` est stowé vers `~/`.

```
~/dotfiles/home/.config/hypr/        → ~/.config/hypr/
~/dotfiles/home/.config/fish/        → ~/.config/fish/
~/dotfiles/home/.config/kitty/       → ~/.config/kitty/
~/dotfiles/home/.config/waybar/      → ~/.config/waybar/
~/dotfiles/home/.config/omarchy/     → ~/.config/omarchy/  (partiel, voir ci-dessous)
```

Pour ajouter un fichier au repo : le déplacer dans `~/dotfiles/home/...` puis `stow --adopt -d ~/dotfiles -t ~ home`.

## Omarchy — règles importantes

**Ne jamais modifier** `~/.local/share/omarchy/` — écrasé par `omarchy update`. Lecture seule.

Les customisations vont dans :
- `~/.config/omarchy/themes/<theme>/` — override de couleurs (colors.toml, etc.)
- `~/.config/omarchy/themed/*.tpl` — override de templates UI (mako, waybar, etc.)

Ces deux dossiers sont dans le repo dotfiles sous `home/.config/omarchy/`.

## Thème actif : Tokyo Night custom

Overrides dans `~/.config/omarchy/themes/tokyo-night/colors.toml` :
- Pas de bleu — bleus et violets remplacés par blanc/gris
- `accent = "#ffffff"` (bordures blanches dans mako, walker)
- `background = "#000000"` (fond noir)
- Rouge, vert, jaune syntaxiques inchangés

Template mako dans `~/.config/omarchy/themed/mako.ini.tpl` :
- Font : JetBrains Mono Nerd Font Mono 14

Appliquer les changements : `omarchy theme set "Tokyo Night"`

## Walker (app launcher)

Walker tourne en **service** (`--gapplication-service`) — il met en cache son CSS au démarrage.
**Après tout changement de thème ou CSS walker : `pkill walker`** pour forcer le rechargement.

Ne pas créer `~/.local/share/walker/themes/` — ça court-circuite l'`additional_theme_location` et casse tous les thèmes.

## Commandes utiles

```bash
omarchy theme set "Tokyo Night"   # appliquer le thème
omarchy theme list                 # thèmes disponibles
omarchy restart waybar             # redémarrer waybar
pkill walker                       # recharger walker
hyprctl reload && hyprctl configerrors   # valider la config Hyprland
notify-send "Test" "message"       # tester mako
```

## Git

```bash
git -C ~/dotfiles status
git -C ~/dotfiles add -p
git -C ~/dotfiles commit -m "..."
```
