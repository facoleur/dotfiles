function vf
    set file (fd --type f | fzf)
    test -n "$file"; and code "$file"
end

function c
    set dir (fd --type d | fzf)
    test -n "$dir"; and code "$dir"
end
