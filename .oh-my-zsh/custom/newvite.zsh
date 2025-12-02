# -------------------------------------------------------------------------
# newvite <project‑name>
# • Clones starter via SSH
# • Installs deps with pnpm
# • Opens VS Code in the new folder
# • Launches Vite dev server
# -------------------------------------------------------------------------
newvite () {
  local app="${1:-my-app}"

  [[ -e "$app" ]] && { echo "✖ '$app' already exists – choose another name." >&2; return 1; }

  # Ensure required commands are available
  for cmd in pnpm git code; do
    command -v $cmd >/dev/null || { echo "✖ $cmd not found on PATH." >&2; return 127; }
  done

  # Prompt user to choose template
  echo "Choose a template:"
  echo "  1) React + JS + Tailwind + DaisyUI + Router (default)"
  echo "  2) React + TypeScript + Tailwind + DaisyUI + Router"
  echo -n "Enter choice [1-2] (default: 1): "
  read -r choice

  # Set repo based on choice
  case "${choice:-1}" in
    1)
      local repo="git@github.com:ReynkeDeVos/vite-react-js-tailwind-daisy-template.git"
      ;;
    2)
      local repo="git@github.com:ReynkeDeVos/vite-react-ts-tailwind-daisyui-router-template.git"
      ;;
    *)
      echo "✖ Invalid choice. Using default template." >&2
      local repo="git@github.com:ReynkeDeVos/vite-react-js-tailwind-daisy-template.git"
      ;;
  esac

  # 1 Clone template (shallow, no history)
  git clone --depth 1 "$repo" "$app" || return $?

  # 2 Start fresh git history
  rm -rf "$app/.git"

  # 3 Install dependencies
  cd "$app" || return
  pnpm install || return $?

  # 4 Open VS Code (background)
  code . &

  # 5 Launch dev server
  pnpm dev
}

# Optional shortcut
alias newv='newvite'
