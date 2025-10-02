# -------------------------------------------------------------------------
# newvite <project‑name>
# • Clones starter via SSH
# • Installs deps with pnpm
# • Opens VS Code in the new folder
# • Launches Vite dev server
# -------------------------------------------------------------------------
newvite () {
  local repo="git@github.com:ReynkeDeVos/vite-react-tailwind-daisy-template.git"
  local app="${1:-my-app}"

  [[ -e "$app" ]] && { echo "✖ '$app' already exists – choose another name." >&2; return 1; }

  # Ensure required commands are available
  for cmd in pnpm git code; do
    command -v $cmd >/dev/null || { echo "✖ $cmd not found on PATH." >&2; return 127; }
  done

  # 1 Clone template (shallow, no history)
  git clone --depth 1 "$repo" "$app" || return $?

  # 2 Start fresh git history
  rm -rf "$app/.git"

  # 3 Install dependencies
  cd "$app" || return
  pnpm install || return $?

  # 4 Open VS Code (background)
  code . &

  # 5 Launch dev server
  pnpm dev
}

# Optional shortcut
alias newv='newvite'
