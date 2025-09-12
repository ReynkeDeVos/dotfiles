# Profile startup (run `zprof` after a fresh shell to see breakdown)
# zmodload zsh/zprof

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# -------------------
# CACHED COMPINIT (run before OMZ; ask OMZ to skip its own)
# -------------------
export skip_global_compinit=1
export ZSH_DISABLE_COMPFIX="true"   # we'll fix perms once; skip prompts
autoload -Uz compinit
# Rebuild if older than 1 day; else trust cached dump
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qNmh+1) ]]; then
  compinit -i
else
  compinit -C -i
fi

# # -------------------
# # LAZY STATIC COMPLETIONS (pure zsh)
# # -------------------
# # Store generated completion files here (first <Tab> per tool).
# : ${ZSH_STATIC_COMP_DIR:="$HOME/.zsh/completions"}
# fpath=($ZSH_STATIC_COMP_DIR $fpath)

# Map commands -> generator command. ONLY add tools NOT already shipped in
# /usr/share/zsh/site-functions/_* or /usr/share/zsh/functions/Completion/*/_*
# typeset -gA LAZY_COMP_GEN=(
#   pnpm      'pnpm completion zsh'
#   viu-media 'viu-media completions --zsh'
# )

# # Generate on first <Tab>, then reinit completion.
# _lazy_static_completion() {
#   local tool=$1
#   local file=$ZSH_STATIC_COMP_DIR/_$tool

#   if [[ ! -e $file ]]; then
#     mkdir -p -- $ZSH_STATIC_COMP_DIR
#     if [[ -n ${LAZY_COMP_GEN[$tool]} ]]; then
#       eval "${LAZY_COMP_GEN[$tool]} >| $file" 2>/dev/null || { rm -f -- "$file"; return 1; }
#       # Refresh completion so the new file is picked up
#       rm -f -- ${ZDOTDIR:-$HOME}/.zcompdump(N) ${ZDOTDIR:-$HOME}/.zcompdump.zwc(N)
#       autoload -Uz compinit
#       compinit -i
#     else
#       return 1
#     fi
#   fi

#   if (( $+functions[_$tool] )); then
#     "_$tool"
#   else
#     _files
#   fi
# }

# # Helper to bind the lazy completion shim
# lazy_compdef() { for cmd in "$@"; do compdef "_lazy_static_completion $cmd" "$cmd"; done }

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
# LOAD OH MY ZSH (compinit already done)
# -------------------
source "$ZSH/oh-my-zsh.sh"

# -------------------
# Carapace completion (https://github.com/rsteube/carapace)
# Load after Oh My Zsh so OMZ has finished initializing.
export CARAPACE_BRIDGES='zsh'

# Cosmetic completion message (optional)
# zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m%F{244}⟫'
# grey colours:
zstyle ':completion:*' format '%K{244}%F{0} ⟫ %d %f%k'
# pastel colours:
# zstyle ':completion:*' format '%K{147}%F{0} ⟫ %d %f%k'
# Keep results relevant (files last unless explicitly completing paths)
zstyle ':completion:*' group-order \
  'arguments' \
  'options' \
  'main commands' 'alias commands' 'external commands' \
  'values' \
  'paths' 'files' 'directories' \
  'parameters' 'aliases' 'functions' 'builtins' 'reserved-words' 'commands'

# Register Carapace completers for zsh
# keep CARAPACE_BRIDGES above this line so bridges are applied
source <(carapace _carapace)

# -------------------
# REGISTER LAZY COMPLETIONS (AFTER compinit/OMZ)
# ONLY include commands you listed in LAZY_COMP_GEN
# -------------------
# lazy_compdef pnpm viu-media

# # -------------------
# # DEFER HEAVY PLUGINS UNTIL AFTER FIRST PROMPT
# # (pure zsh; no external helper)
# # -------------------
# autoload -Uz add-zsh-hook

# # fast-syntax-highlighting (your install path):
# # We defer it because its widget-binding shows as _zsh_highlight_bind_widgets in zprof.
# __fastsh_loaded=0
# __fastsh_boot() {
#   (( __fastsh_loaded )) && return
#   __fastsh_loaded=1
#   # Source your existing plugin (adjust if you move it)
#   local fastsh="$ZSH_CUSTOM/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh"
#   [[ -r $fastsh ]] && source "$fastsh"
# }
# add-zsh-hook precmd __fastsh_boot

# # zsh-autopair — also defer to after first prompt
# __autopair_loaded=0
# __autopair_boot() {
#   (( __autopair_loaded )) && return
#   __autopair_loaded=1
#   typeset -f autopair-init >/dev/null && autopair-init
# }
# add-zsh-hook precmd __autopair_boot

# --------------------------------------------
# PREFERRED EDITOR
# --------------------------------------------
export EDITOR='micro'
# Or 'nano', 'vim', 'code -w', etc.
# export SUDO_EDITOR='micro'

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
  eval "$(zoxide init --cmd cd zsh)"
fi

# --------------------------------------------
# HISTORY-SUBSTRING-SEARCH KEYBINDINGS
# --------------------------------------------
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down

# --------------------------------------------
# STARSHIP PROMPT INITIALIZATION
# --------------------------------------------
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
fi

# -------------------
# ENV/PATH
# -------------------
export BROWSER='google-chrome-stable' # Set your preferred browser for command-line tools.
export SSH_AUTH_SOCK=~/.1password/agent.sock # Use 1Password as the SSH Agent

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# Boot.dev CLI
export PATH="$PATH:$HOME/go/bin"

# -------------------
# Keybindings: Alt+Arrows
# -------------------
# backward-word on Alt+Left
bindkey '\e[1;3D' backward-word
# forward-word on Alt+Right
bindkey '\e[1;3C' forward-word
# (optionally) scroll through multiline editing on Alt+Up/Down:
bindkey '\e[1;3A' up-line-or-history
bindkey '\e[1;3B' down-line-or-history


# -------------------
# One-time: fix insecure paths so compaudit stops churning
# Run this once manually, then keep commented:
# compaudit | xargs -r -I{} chmod -R go-w '{}'


# zprof