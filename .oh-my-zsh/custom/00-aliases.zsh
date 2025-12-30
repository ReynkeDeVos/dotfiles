# --------------------------------------------
# CUSTOM ALIASES & FUNCTIONS
# --------------------------------------------
# This file is sourced automatically by Oh My Zsh.

# echo "✅ alias file loaded"

alias cls='clear'
alias zshconfig='${EDITOR:-fresh} ~/.zshrc'
alias src='source ~/.zshrc && echo "Zsh config reloaded!"'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# --------------------------------------------
# LSD (Modern ls replacement) ALIASES
# --------------------------------------------
if (( $+commands[lsd] )); then
  alias ls='lsd --group-directories-first'
  alias lt='ls --tree'
else
  alias ls='ls --color=auto'
fi
# These rely on 'ls' being set above
alias l='ls -l'
alias la='ls -A'
alias lla='ls -lA'


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
