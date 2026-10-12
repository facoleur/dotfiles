function c
    set -l dir (
        find -L "$HOME" /home/$USER -mindepth 1 -maxdepth 3 -type d 2>/dev/null |
        fzf --reverse --height=60% --border
    )

    code $dir
end
