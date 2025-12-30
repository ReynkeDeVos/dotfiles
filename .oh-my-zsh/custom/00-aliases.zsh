# --------------------------------------------
# CUSTOM ALIASES & FUNCTIONS
# --------------------------------------------
# This file is sourced automatically by Oh My Zsh.

# echo "✅ alias file loaded"

# Clean stale .zwc cache files and broken symlinks in oh-my-zsh custom dir
# ! renamed dotfiles → run zsh-cleanup && src to reload
zsh-cleanup() {
  local custom_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  echo "Cleaning stale files in $custom_dir..."
  
  # Remove .zwc compiled caches
  find "$custom_dir" -maxdepth 1 -name "*.zwc" -delete -print 2>/dev/null
  
  # Remove broken symlinks
  find "$custom_dir" -maxdepth 1 -xtype l -delete -print 2>/dev/null
  
  echo "Done! Run 'src' to reload."
}

alias cls='clear'
alias zshconfig='${EDITOR:-fresh} ~/.zshrc'
alias src='source ~/.zshrc && echo "Zsh config reloaded!"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# --------------------------------------------
# EZA (Modern ls replacement) ALIASES
# --------------------------------------------
if (( $+commands[eza] )); then
  # Base eza command with icons, colors, and directories first
  alias ls='eza --icons=auto --color=auto --group-directories-first'
  
  # Long listing with git status and human-readable sizes
  alias l='eza --icons=auto --color=auto --group-directories-first -l --git --header --time-style=relative'
  
  # Show hidden files
  alias la='eza --icons=auto --color=auto --group-directories-first -a'
  
  # Long listing with hidden files
  alias lla='eza --icons=auto --color=auto --group-directories-first -a -l --git --header --time-style=relative'
  
  # Tree view (beautiful!)
  alias lt='eza --icons=auto --color=auto --group-directories-first --tree --level=2'
  alias lt3='eza --icons=auto --color=auto --group-directories-first --tree --level=3'
  alias lta='eza --icons=auto --color=auto --group-directories-first --tree --level=2 -a'
  
  # Extended info (permissions, owner, size, git)
  alias ll='eza --icons=auto --color=auto --group-directories-first -l --git --header --time-style=long-iso'
  
  # Just directories
  alias lsd='eza --icons=auto --color=auto -D'
  
  # Sort by modification time (newest first)
  alias lsn='eza --icons=auto --color=auto --group-directories-first -l --git --sort=modified --reverse'
  
  # Sort by size (largest first)  
  alias lss='eza --icons=auto --color=auto --group-directories-first -l --git --sort=size --reverse'
else
  # Fallback to standard ls
  alias ls='ls --color=auto'
  alias l='ls -lh'
  alias la='ls -A'
  alias lla='ls -lAh'
  alias lt='tree -L 2'
fi


# --------------------------------------------
# YAZI (Terminal File Manager) ALIAS
# --------------------------------------------
if (( $+commands[yazi] )); then
  alias y='yazi'
fi

# System Monitoring
if (( $+commands[btop] )); then
  alias top='btop'
  alias htop='btop'
fi

if (( $+commands[nvim] )); then
  alias vim='nvim'
  alias v='nvim'
  alias nv='nvim'
fi

if (( $+commands[lazygit] )); then
  alias lg='lazygit'
fi

alias p='pnpm'
alias idev='pnpm install && pnpm run dev'

if (( $+commands[rga] )); then
  alias grep='rga --hidden --smart-case --follow'
  #(includes ignored files)
  alias grepi='rga --hidden --smart-case --follow -uu'

  # Interactive fuzzy search with rga + fzf (searches PDFs, archives, docs, etc.)
  rga-fzf() {
    RG_PREFIX="rga --files-with-matches"
    local file
    file="$(
      FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
        fzf --sort \
            --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
            --phony -q "$1" \
            --bind "change:reload:$RG_PREFIX {q}" \
            --preview-window="70%:wrap"
    )" &&
    echo "Opening $file" &&
    xdg-open "$file"
  }
fi

if (( $+commands[xcp] )); then
  alias cp='xcp'
fi

if (( $+commands[trash] )); then
  alias rm='trash -v'
fi

if (( $+commands[gping] )); then
  alias ping='gping'
fi

alias oc='opencode'

if (( $+commands[helix] )); then
  alias hx='helix'
fi

alias weather='curl wttr.in'
alias coffee='ssh terminal.shop'

if (( $+commands[ttyd] )); then
  alias webterm='ttyd -W -t fontFamily="\"CaskaydiaCove NF\",\"Symbols Nerd Font\",monospace" -t fontSize=14 -t cursorBlink=true -t lineHeight=1.1 -t theme="{\"background\":\"#0b0e14\",\"foreground\":\"#e6e1cf\",\"cursor\":\"#ffcc66\"}" "$SHELL"'
fi
