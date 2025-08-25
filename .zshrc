# zmodload zsh/zprof

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"


# Faster loading by only checking completion dump once a day
# Completion init (safer & per-host)
autoload -Uz compinit
ZCOMP_CACHEDUMP="${ZDOTDIR:-$HOME}/.zcompdump-${HOST}"
if [[ -n ${ZCOMP_CACHEDUMP}(#qN.mh+24) ]]; then
  compinit -i -d "$ZCOMP_CACHEDUMP"
else
  compinit -i -C -d "$ZCOMP_CACHEDUMP"
fi

# -------------------
# OH MY ZSH SETTINGS
# -------------------
ZSH_THEME=""

# Note: Oh My Zsh updates are handled by the custom script in ~/.oh-my-zsh/custom/
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Oh My Zsh custom folder
export ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

# -------------------
# PLUGINS
# -------------------
plugins=(
    git
    archlinux    # Pacman/Yay aliases
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
setopt AUTO_CD              # Auto cd if only a directory is given
setopt AUTO_PUSHD           # Push directory onto stack after cd
setopt PUSHD_IGNORE_DUPS    # Don't push duplicate directories
setopt CORRECT              # Auto correct mistakes
setopt HIST_IGNORE_ALL_DUPS # If you want to remove all duplicates from history
# setopt HIST_IGNORE_DUPS     # Do not write events to history that are duplicates of the previous event
setopt HIST_REDUCE_BLANKS   # Remove superfluous blanks from history items
setopt INC_APPEND_HISTORY   # Write history incrementally, don't wait until shell exit
setopt SHARE_HISTORY        # Share history between all sessions (useful with INC_APPEND_HISTORY)
setopt EXTENDED_GLOB        # Use extended globbing features

# --------------------------------------------
# HISTORY SETTINGS
# --------------------------------------------
export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000

# --------------------------------------------
# LOAD OH MY ZSH & CUSTOM CONFIGS
# --------------------------------------------
# This loads Oh My Zsh and automatically sources all .zsh files in $ZSH_CUSTOM
source $ZSH/oh-my-zsh.sh

# --------------------------------------------
# LAZY LOADING FUNCTIONS (guarded)
# --------------------------------------------
# Lazy load GitHub CLI
gh() {
  if ! command -v gh >/dev/null 2>&1; then
    print -P "%F{yellow}GitHub CLI (gh) not installed.%f"
    return 127
  fi
  unfunction gh
  eval "$(gh completion -s zsh)"
  command gh "$@"
}

# Lazy load pnpm
pnpm() {
  if [[ -r "$ZSH_CUSTOM/plugins/pnpm/pnpm.plugin.zsh" ]]; then
    unfunction pnpm
    source "$ZSH_CUSTOM/plugins/pnpm/pnpm.plugin.zsh"
    command pnpm "$@"
  else
    if ! command -v pnpm >/dev/null 2>&1; then
      print -P "%F{yellow}pnpm not installed and pnpm plugin not found.%f"
      return 127
    fi
    unfunction pnpm
    command pnpm "$@"
  fi
}


# --------------------------------------------
# COMPLETION HELPERS (replace custom _files)
# --------------------------------------------
# Generic helper: try common "print zsh completions" forms and eval the output.
__try_eval_zsh_completion() {
  local bin="$1" out form
  [[ -z "$bin" || ! $(command -v "$bin") ]] && return 1
  # If distro already installed a completion file, nothing to do.
  [[ -e "/usr/share/zsh/site-functions/_${bin}" ]] && return 0
  local -a forms=(
    "$bin completion zsh"
    "$bin completions zsh"
    "$bin --completion zsh"
    "$bin --completions zsh"
    "$bin generate-completions zsh"
    "$bin gen-completions zsh"
  )
  for form in "${forms[@]}"; do
    if out="$(eval "$form" 2>/dev/null)"; then
      eval "$out"
      return 0
    fi
  done
  return 1
}

# pnpm: use built-in generator (no custom _pnpm file needed)
if command -v pnpm >/dev/null 2>&1; then
  eval "$(pnpm completion zsh)"
fi

# spotify_player: try to self-generate if no system completion exists
__try_eval_zsh_completion spotify_player



# --------------------------------------------
# FZF (Fuzzy Finder)
# --------------------------------------------
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude node_modules'
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --plain {} || head -n 200 {}'"
# Optional nicer UI defaults
export FZF_DEFAULT_OPTS="${FZF_DEFAULT_OPTS:-} --height=40% --layout=reverse --info=inline"

# --------------------------------------------
# ZOXIDE (Intelligent cd)
# --------------------------------------------
eval "$(zoxide init --cmd cd zsh)"

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
else
  print -P "%F{yellow}Starship command not found.%f"
fi

# Set your preferred browser for command-line tools.
export BROWSER='google-chrome-stable'

# Use 1Password as the SSH Agent
export SSH_AUTH_SOCK=~/.1password/agent.sock

# ——— Map Alt+Arrow to word-wise movement ———
# backward-word on Alt+Left
bindkey '\e[1;3D' backward-word
# forward-word on Alt+Right
bindkey '\e[1;3C' forward-word
# (optionally) scroll through multiline editing on Alt+Up/Down:
bindkey '\e[1;3A' up-line-or-history
bindkey '\e[1;3B' down-line-or-history

# pnpm
export PNPM_HOME="/home/kawa/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Boot.dev CLI
export PATH=$PATH:$HOME/go/bin

# zprof
