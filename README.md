# Dotfiles

Personal Omarchy dotfiles and package bootstrap.

## What This Does

- Installs packages listed in `packages.txt` with `yay`.
- Applies files from `home/` into `$HOME` with GNU Stow.
- Backs up conflicting files before applying dotfiles.

## Add Packages

Add one package name per line in `packages.txt`:

```txt
firefox
fish
zed
```

Run the bootstrap again to install new packages.

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

The script installs packages, applies dotfiles, and stores backups in `dotfiles_backup/` when conflicts are found.
