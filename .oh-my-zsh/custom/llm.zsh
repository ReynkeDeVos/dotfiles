# LLM launcher for oh-my-zsh
# Provides an `LLM` command that shows a simple menu to start
# one of the installed CLIs: Claude, Gemini, or Codex (ChatGPT).

# Usage:
#   LLM [args...]
# Any extra args are passed through to the selected CLI.

function LLM() {
  emulate -L zsh
  setopt localoptions no_aliases

  local -a options cmds

  # Helper: add first available command under a display label
  add_cmd() {
    local label="$1"; shift
    local candidate
    for candidate in "$@"; do
      if command -v "$candidate" >/dev/null 2>&1; then
        options+=("$label")
        cmds+=("$candidate")
        return 0
      fi
    done
    return 1
  }

  # Detect known binaries (check multiple likely names)
  add_cmd "Claude" claude claude-code
  add_cmd "Gemini" gemini gemini-cli
  add_cmd "Codex" codex openai-codex

  if (( ${#options[@]} == 0 )); then
    echo "No supported LLM CLIs found in PATH (claude/claude-code, gemini/gemini-cli, codex)." >&2
    return 127
  fi

  # If only one is available, launch it directly
  if (( ${#options[@]} == 1 )); then
    exec "${cmds[1]}" "$@"
  fi

  echo "Select LLM CLI to run:"
  local PS3="Enter choice [1-$(( ${#options[@]} + 1 ))]: "
  select opt in "${options[@]}" "Cancel"; do
    case "$REPLY" in
      ''|*[!0-9]*) echo "Invalid selection."; continue ;;
    esac
    if (( REPLY >= 1 && REPLY <= ${#options[@]} )); then
      exec "${cmds[$REPLY]}" "$@"
    elif (( REPLY == ${#options[@]} + 1 )); then
      return 0
    else
      echo "Invalid selection."
    fi
  done
}

# Convenience: lowercase alias
alias llm=LLM

