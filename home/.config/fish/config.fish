if status is-interactive
    # Commands to run in interactive sessions can go here
end

if not pgrep -u (whoami) ssh-agent > /dev/null
    ssh-agent -c | source
end

ssh-add ~/.ssh/id2 2>/dev/null


# pnpm
set -gx PNPM_HOME "/home/facoleur/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
export PATH="$HOME/.local/bin:$PATH"

fish_add_path -a "/home/facoleur/.config/.foundry/bin"

fish_add_path -a "/home/facoleur/.config/.foundry/bin"

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH
alias zedium='~/zed/target/release/zed'
