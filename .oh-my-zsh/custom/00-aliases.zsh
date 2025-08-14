# --------------------------------------------
# CUSTOM ALIASES & FUNCTIONS
# --------------------------------------------
# This file is sourced automatically by Oh My Zsh.

# echo "✅ alias file loaded"

alias cls='clear'
alias zshconfig='${EDITOR:-micro} ~/.zshrc'
alias src='source ~/.zshrc && echo "Zsh config reloaded!"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# --------------------------------------------
# LSD (Modern ls replacement) ALIASES
# --------------------------------------------
alias ls='lsd --group-directories-first'
alias l='ls -l'
alias la='ls -A'
alias lla='ls -lA'
alias lt='ls --tree'

# --------------------------------------------
# YAZI (Terminal File Manager) ALIAS
# --------------------------------------------
alias y='yazi'

# System Monitoring
alias top='btop'
alias htop='btop'

alias vim='nvim'
alias v='nvim'

alias lg='lazygit'

alias p='pnpm'
alias idev='pnpm install && pnpm run dev'

alias grep='rg --hidden --smart-case --follow'
#(includes ignored files)
alias grepi='rg --hidden --smart-case --follow -uu' 

alias cp='xcp'
alias rm='trash -v'
alias ping='gping'

alias weather='curl wttr.in'
alias coffee='ssh terminal.shop'
