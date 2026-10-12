function coder
    set -l dir (
        ssh dev 'find -L "$HOME" /srv -mindepth 1 -maxdepth 3 -type d 2>/dev/null' |
        fzf --reverse --height=60% --border
    )

    if test -z "$dir"
        return 1
    end

    code --folder-uri "vscode-remote://ssh-remote+dev$dir"
end
