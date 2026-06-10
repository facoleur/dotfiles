function git_branch
    set branch (git symbolic-ref --short HEAD 2>/dev/null)
    if test -n "$branch"
        echo -n "$branch"
    end
end

function fish_prompt
    set branch (git_branch)
    set cwd (prompt_pwd)

    set_color normal
    if test -n "$branch"
        echo -n -s (set_color --bold blue) "["  $branch "]"
    end
    echo -n -s  (set_color --bold yellow)   "[" $cwd "] " (set_color normal)
end

