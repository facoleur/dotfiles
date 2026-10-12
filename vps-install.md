sudo apt update
sudo apt upgrade
sudo apt install fish zoxide rip-grep fd-find kitty-terminfo mosh gh caddy
chsh -s /usr/bin/fish
curl -sS https://starship.rs/install.sh | sh


curl -fsSL https://claude.ai/install.sh | bash
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.config/fish/config.fish && source ~/.config/fish/config.fish
zoxide init fish | source
