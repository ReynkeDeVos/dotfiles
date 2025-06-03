# --------------------------------------------
# CUSTOM ALIASES & FUNCTIONS
# --------------------------------------------
# Place your personal aliases here.
# This file is sourced by ~/.zshrc

alias cls='clear'
alias zshconfig='${EDITOR:-micro} ~/.zshrc' # Uses $EDITOR, defaults to nano if not set
alias src='source ~/.zshrc && echo "Zsh config reloaded!"' # Added a confirmation message
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Example: git aliases
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gca='git commit -am'
alias gs='git status -sb' # Short branch status
alias gp='git push'
alias gpull='git pull'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"


# --------------------------------------------
# LSD (Modern ls replacement) ALIASES
# --------------------------------------------
# These are good to keep even if the 'aliases' plugin provides some 'ls' ones,
# as these are specific to lsd.
alias ls='lsd --group-directories-first'
alias l='ls -l'
alias la='ls -A' # Show hidden files
alias lla='ls -lA' # Show hidden files in long format
alias lt='ls --tree'

# --------------------------------------------
# YAZI (Terminal File Manager) ALIAS
# --------------------------------------------
alias y='yazi'

# System Monitoring
alias top='btop'
alias htop='btop'

alias vim='nvim'

alias lg='lazygit'

alias p='pnpm' # for the lazy loading to take effect

alias dev='pnpm run dev'

# Add other aliases you use frequently!
alias weather='curl wttr.in'