function c --description "Ouvre un dossier dans VS Code via fzf"
    set -l dir (find -L $HOME -mindepth 1 -maxdepth 3 -type d 2>/dev/null | fzf --reverse --height=60% --border)

    if test -n "$dir"
        code $dir
    end
end
