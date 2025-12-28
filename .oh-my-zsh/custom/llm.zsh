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
  local selected_cmd

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
  add_cmd "Copilot" copilot
  add_cmd "OpenCode" opencode
  add_cmd "Crush" crush

  if (( ${#options[@]} == 0 )); then
    echo "No supported LLM CLIs found in PATH." >&2
    return 127
  fi

  # Handle direct argument if provided
  if [[ -n "$1" ]]; then
    case "${1:l}" in # :l converts to lowercase
      claude)   selected_cmd="claude" ;;
      gemini)   selected_cmd="gemini" ;;
      chatgpt|codex) selected_cmd="codex" ;;
      copilot)  selected_cmd="copilot" ;;
      opencode) selected_cmd="opencode" ;;
      crush)    selected_cmd="crush" ;;
    esac

    # Attempt to find the binary for the selected alias
    if [[ -n "$selected_cmd" ]]; then
      # We need to find which actual binary corresponds to this selection
      if command -v "$selected_cmd" >/dev/null 2>&1; then
        shift
        "$selected_cmd" "$@"
        return 0
      fi
    fi
  fi

  # If only one is available, launch it directly
  if (( ${#options[@]} == 1 )); then
    "${cmds[1]}" "$@"
    return
  fi

  echo "Select LLM CLI to run:"
  local i=1
  for opt in "${options[@]}"; do
    printf "%d) %s  " "$i" "$opt"
    ((i++))
  done
  printf "q) Cancel\n"

  local choice
  while true; do
    echo -n "> "
    read -k 1 choice # Read 1 char
    echo

    if [[ "$choice" == [qQ] ]]; then
      return 0
    elif [[ "$choice" =~ ^[1-9]$ ]] && (( choice <= ${#options[@]} )); then
      "${cmds[$choice]}" "$@"
      break
    else
      echo "Invalid selection."
    fi
  done
}

# Convenience: lowercase alias
alias llm=LLM
