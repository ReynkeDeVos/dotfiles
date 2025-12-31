# Profile startup (run `zprof` after a fresh shell to see breakdown)
# zmodload zsh/zprof

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# -------------------
# DEFER COMPINIT (let OMZ handle it, but skip checks)
# -------------------
export ZSH_DISABLE_COMPFIX="true"   # skip permission checks

# -------------------
# OH MY ZSH SETTINGS
# -------------------
ZSH_THEME=""
# Keep OMZ fast & quiet
export DISABLE_AUTO_UPDATE="true"
export UPDATE_ZSH_DAYS=30
# export ZSH_DISABLE_COMPFIX="true"
export DISABLE_UNTRACKED_FILES_DIRTY="true"

# -------------------
# PLUGINS
# -------------------
plugins=(
    # git
    # archlinux    # Pacman/Yay aliases
    history      # Zsh history improvements
    colored-man-pages # Colorize man pages
    # aliases     # Common useful aliases (some might be duplicated in your custom aliases.zsh, review as needed)
    # gh           # For GitHub CLI completions and aliases (needs gh installed)
    # 1password    # For 1Password CLI completions (needs 1Password CLI installed)
    # alias-finder # Helps find existing aliases for commands
    # fzf        # Basic fzf plugin from Oh My Zsh (can be used alongside manual setup for extra aliases if desired)
    # sudo         # Press Esc twice to prepend sudo
    # pnpm         # For pnpm completions and aliases.

    # Custom plugins (cloned into $ZSH_CUSTOM/plugins)
    zsh-autopair    
    # autoupdate # upgrades custom installed plugins. Maybe switch to pacman installs?
    history-substring-search
    zsh-autosuggestions   # more like fish: one gray inline suggestion
    # zsh-autocomplete   # displays all options / history - loads super slow
    fast-syntax-highlighting
    # zsh-syntax-highlighting # IMPORTANT: This should generally be the LAST plugin in the list
)

# -------------------
# LOAD OH MY ZSH
# -------------------
FPATH="$ZSH/completions:$FPATH"
source "$ZSH/oh-my-zsh.sh"

# -------------------
# Carapace completion (https://github.com/rsteube/carapace)
# -------------------
export CARAPACE_BRIDGES='zsh'

# Cosmetic completion message (optional)
zstyle ':completion:*' format '%K{244}%F{0} ⟫ %d %f%k'
zstyle ':completion:*' group-order \
  'arguments' \
  'options' \
  'main commands' 'alias commands' 'external commands' \
  'values' \
  'paths' 'files' 'directories' \
  'parameters' 'aliases' 'functions' 'builtins' 'reserved-words' 'commands'

# Lazy-load Carapace: only initialize when tab completion is first used
# This avoids 1400+ compdef calls on every shell startup
if command -v carapace >/dev/null 2>&1; then
  _carapace_lazy_init() {
    # Remove this hook
    unfunction _carapace_lazy_init 2>/dev/null
    # Load carapace
    source <(carapace _carapace)
  }
  # Hook into first completion attempt
  compdef _carapace_lazy_init carapace
fi

# --------------------------------------------
# PREFERRED EDITOR
# --------------------------------------------
export EDITOR='fresh'
# Or 'nano', 'vim', 'code -w', etc.
# export SUDO_EDITOR='fresh'

# --------------------------------------------
# ZSH OPTIONS (setopt / unsetopt)
# --------------------------------------------
# For a comprehensive list: `man zshoptions`
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS               # Auto cd if only a directory is given # Push directory onto stack after cd # Don't push duplicate directories
setopt CORRECT              # Auto correct mistakes 
setopt HIST_IGNORE_ALL_DUPS HIST_REDUCE_BLANKS # If you want to remove all duplicates from history  # Remove superfluous blanks from history items
# setopt HIST_IGNORE_DUPS     # Do not write events to history that are duplicates of the previous event
setopt INC_APPEND_HISTORY SHARE_HISTORY  # Write history incrementally, don't wait until shell exit   # Share history between all sessions (useful with INC_APPEND_HISTORY)
setopt EXTENDED_GLOB        # Use extended globbing features

# --------------------------------------------
# HISTORY SETTINGS
# --------------------------------------------
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# --------------------------------------------
# FZF (Fuzzy Finder)
# --------------------------------------------
if [[ -r /usr/share/fzf/key-bindings.zsh ]]; then
  source /usr/share/fzf/key-bindings.zsh
fi
if [[ -r /usr/share/fzf/completion.zsh ]]; then
  source /usr/share/fzf/completion.zsh
fi
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude node_modules'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --plain {} || head -n 200 {}'"
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:-} --height=40% --layout=reverse --info=inline"

# --------------------------------------------
# ZOXIDE (Intelligent cd)
# --------------------------------------------
if command -v zoxide >/dev/null 2>&1; then
  _zoxide_cache="${XDG_CACHE_HOME:-$HOME/.cache}/zoxide_init.zsh"
  if [[ ! -f "$_zoxide_cache" || ! -s "$_zoxide_cache" ]]; then
    zoxide init --cmd cd zsh > "$_zoxide_cache"
  fi
  source "$_zoxide_cache"
fi

# --------------------------------------------
# HISTORY-SUBSTRING-SEARCH KEYBINDINGS
# --------------------------------------------
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down

# --------------------------------------------
# STARSHIP PROMPT INITIALIZATION
# --------------------------------------------
if command -v starship &>/dev/null; then
  _starship_cache="${XDG_CACHE_HOME:-$HOME/.cache}/starship_init.zsh"
  if [[ ! -f "$_starship_cache" || ! -s "$_starship_cache" ]]; then
    starship init zsh > "$_starship_cache"
  fi
  source "$_starship_cache"
fi

# -------------------
# ENV/PATH
# -------------------
export BROWSER='helium-browser' # Set your preferred browser for command-line tools.
export SSH_AUTH_SOCK=~/.1password/agent.sock # Use 1Password as the SSH Agent

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# npm
export PATH=$HOME/.npm-global/bin:$PATH

# Boot.dev CLI
export PATH="$PATH:$HOME/go/bin"

# -------------------
# Keybindings
# -------------------
# Alt+Arrows: word navigation
bindkey '\e[1;3D' backward-word      # Alt+Left
bindkey '\e[1;3C' forward-word       # Alt+Right
bindkey '\e[1;3A' up-line-or-history   # Alt+Up
bindkey '\e[1;3B' down-line-or-history # Alt+Down

# Alt+G: rga-fzf (grep through PDFs, archives, docs, etc.)
if (( $+commands[rga] )); then
  _rga-fzf-widget() {
    local file
    RG_PREFIX="rga --files-with-matches"
    file="$(
      FZF_DEFAULT_COMMAND="$RG_PREFIX ''" \
        fzf --sort \
            --height=80% \
            --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
            --phony \
            --bind "change:reload:$RG_PREFIX {q}" \
            --preview-window="right,45%:wrap"
    )"
    if [[ -n "$file" ]]; then
      LBUFFER="${LBUFFER}${file}"
    fi
    zle reset-prompt
  }
  zle -N _rga-fzf-widget
  bindkey '\eg' _rga-fzf-widget
fi

# zprof
