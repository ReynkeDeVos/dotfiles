# zmodload zsh/zprof

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Faster loading by only checking completion dump once a day
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
  compinit
else
  compinit -C
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# -------------------
# OH MY ZSH SETTINGS
# -------------------
# ZSH_THEME is not needed when using Starship, as Starship manages the prompt.
# Setting ZSH_THEME to empty or commenting it out is recommended.
ZSH_THEME=""

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# HIST_STAMPS="mm/dd/yyyy"

# Oh My Zsh custom folder
# This ensures $ZSH_CUSTOM is correctly defined for sourcing custom files like aliases.zsh
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
    
    # Custom plugins (cloned into $ZSH_CUSTOM/plugins)
    # pnpm         # For pnpm completions and aliases.
    zsh-autopair
    history-substring-search
    # zsh-autocomplete   # displays all options / history
    zsh-autosuggestions   # more like fish: one gray inline suggestion
    # autoupdate # upgrades custom installed plugins. Maybe switch to pacman installs?
    # zsh-syntax-highlighting # IMPORTANT: This should generally be the LAST plugin in the list
    fast-syntax-highlighting
)

# zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
# zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
# zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
# zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

# --------------------------------------------
# PREFERRED EDITOR
# --------------------------------------------
# Set your preferred editor. Used by `zshconfig` alias and other tools.
export EDITOR='micro' # Or 'nano', 'vim', 'code -w', etc.
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
# This line loads Oh My Zsh. It should be at the end of Zsh plugin manager related settings.
# It also sources $ZSH/custom files and plugins.
source $ZSH/oh-my-zsh.sh

# Source custom aliases from $ZSH_CUSTOM/aliases.zsh (if the file exists)
if [ -f "$ZSH_CUSTOM/aliases.zsh" ]; then
  source "$ZSH_CUSTOM/aliases.zsh"
fi

# Source the custom update system (create this file using the provided template)
if [ -f "$ZSH_CUSTOM/custom-update.zsh" ]; then
  source "$ZSH_CUSTOM/custom-update.zsh"
fi

# --------------------------------------------
# LAZY LOADING FUNCTIONS
# --------------------------------------------
# Lazy load GitHub CLI
gh() {
  unfunction gh
  eval "$(gh completion -s zsh)"
  gh "$@"
}

# Lazy load pnpm
pnpm() {
  unfunction pnpm
  source $ZSH_CUSTOM/plugins/pnpm/pnpm.plugin.zsh
  pnpm "$@"
}

# --------------------------------------------
# PNPM PATH (Handled by pnpm installer or OMZ plugin)
# --------------------------------------------
# The Oh My Zsh `pnpm` plugin or pnpm's own installer should handle PATH setup.
# If you installed pnpm via its script, it likely modified this file or ~/.profile.
# Manual setup (usually not needed if plugin/installer works):
# export PNPM_HOME="/home/kawa/.local/share/pnpm"
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac
# pnpm end

# --------------------------------------------
# NVM (Node Version Manager)
# --------------------------------------------
# This should be added to your .zshrc by the nvm installer.
# Make sure these lines are present if you use NVM.
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# --------------------------------------------
# FZF (Fuzzy Finder)
# --------------------------------------------

# Source fzf key bindings and completions for Zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# Configure fzf to use fd and ripgrep for faster searches
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --exclude node_modules'
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --exclude node_modules'

# Optional: Preview window for fzf (CTRL-T) using bat or head
export FZF_CTRL_T_OPTS="--preview 'bat --color=always --plain {} || head -n 200 {}'"

# --------------------------------------------
# ZOXIDE (Intelligent cd)
# --------------------------------------------
# Ensure zoxide is installed (e.g., `yay -S zoxide`)
eval "$(zoxide init --cmd cd zsh)"

# --------------------------------------------
# HISTORY-SUBSTRING-SEARCH KEYBINDINGS
# --------------------------------------------
# Ensure these are after plugin loading and Oh My Zsh sourcing if they modify bindings.
# Bind Up and Down arrow keys to history-substring-search.
# These terminfo capabilities are generally more robust.
bindkey "${terminfo[kcuu1]}" history-substring-search-up
bindkey "${terminfo[kcud1]}" history-substring-search-down
# Fallback if terminfo doesn't work (less common for modern terminals)
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

# --------------------------------------------
# STARSHIP PROMPT INITIALIZATION
# --------------------------------------------
# Starship init should be one of the last things to ensure it can override
# other prompt settings if necessary.
if command -v starship &> /dev/null; then
  eval "$(starship init zsh)"
else
  # Optional: Print a message if starship command is not found
  print -P "%F{yellow}Starship command not found. Prompt will not be customized by Starship.%f"
fi


# Set your preferred browser for command-line tools.
# Ensure 'google-chrome-stable' is in your PATH.
export BROWSER='google-chrome-stable'

# Use Bitwarden as SSH-Manager, although it is still buggy, and 1Password works waaaay better atm
# export SSH_AUTH_SOCK="$HOME/.bitwarden-ssh-agent.sock"
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


# zprof