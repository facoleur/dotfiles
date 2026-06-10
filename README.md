# Omarchy Boostrapper

Personal Omarchy dotfiles, package and appImage bootstrapper.

## What This Does

- Installs packages listed in `packages.txt` with `yay`.
- Installs AppImages listed in `appimages.txt`.
- Applies files from `home/` into `$HOME` with GNU Stow.
- Backs up conflicting files before applying dotfiles.

## Project Tree

```txt
.
|-- README.md
|-- bootstrap.sh           # RUN THIS
|-- packages.txt           # EDIT THIS: packages to install with yay
|-- appimages.txt          # EDIT THIS: AppImages to download and install
|-- home/
|   `-- .config/           # EDIT THIS: app configs, mirrors ~/.config
|-- scripts/
|   |-- packages.sh
|   |-- appimages.sh
|   |-- dotfiles.sh
|   `-- style.sh
`-- dotfiles_backup/       # generated: conflicting files moved here
```

## Add Packages

Add one package name per line in `packages.txt`:

```txt
firefox
fish
zed
```

Run the bootstrap again to install new packages.

## Add AppImages

Add one AppImage per line in `appimages.txt`:

```txt
id|name|url|categories
ledger-live|Ledger Live|https://download.live.ledger.com/latest/linux?c=1|Finance
```

Fields:

- `id`: filename and desktop entry id.
- `name`: app name shown in menus.
- `url`: AppImage download URL.
- `categories`: desktop menu category.

AppImages are installed to `~/.local/bin` and desktop entries are created in `~/.local/share/applications`.

## Add Config Files

Put config files under `home/.config` using the same path they should have in your home directory.

Example:

```txt
home/.config/kitty/kitty.conf
home/.config/fish/config.fish
home/.config/hypr/hyprland.conf
```

These become:

```txt
~/.config/kitty/kitty.conf
~/.config/fish/config.fish
~/.config/hypr/hyprland.conf
```

## Use

From this repo:

```sh
./bootstrap.sh
```

The script installs packages, installs AppImages, applies dotfiles, and stores backups in `dotfiles_backup/` when conflicts are found.
