# --------------------------------------------
# CUSTOM ALIASES & FUNCTIONS
# --------------------------------------------
# This file is sourced automatically by Oh My Zsh.

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

alias p='pnpm' # for the lazy loading to take effect

alias dev='pnpm run dev'

alias weather='curl wttr.in'