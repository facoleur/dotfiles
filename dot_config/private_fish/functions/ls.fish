function ls --wraps='eza --color=always --git' --description 'alias ls=eza --color=always --git'
    eza --color=always --git $argv
end
