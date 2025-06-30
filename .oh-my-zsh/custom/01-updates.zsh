#!/usr/bin/env zsh
#
# Custom Update System for Oh My Zsh and Custom Plugins
#

# Configuration
# ----------------------------------------------
setopt NO_MONITOR
ZSH_CUSTOM_UPDATE_DAYS=7
ZSH_CUSTOM_UPDATE_WORKERS=4
UPDATE_CHECK_FILE="$HOME/.zsh_update_check"

# Main update function
# -------------------
custom_plugins_update() {
  # Check if file doesn't exist or is older than ZSH_CUSTOM_UPDATE_DAYS
  if [[ ! -f $UPDATE_CHECK_FILE ]] || [[ $(find "$UPDATE_CHECK_FILE" -mtime +$ZSH_CUSTOM_UPDATE_DAYS -print) ]]; then
    touch "$UPDATE_CHECK_FILE"
    echo "Checking for updates to Oh My Zsh and custom plugins..."

    # Get all custom plugin and theme directories
    custom_plugins=($ZSH_CUSTOM/plugins/*/.git)
    custom_plugins=("${custom_plugins[@]%/*}")
    custom_themes=($ZSH_CUSTOM/themes/*/.git)
    custom_themes=("${custom_themes[@]%/*}")
    all_custom_repos=(${custom_plugins[@]} ${custom_themes[@]})

    # Update custom repos in parallel
    for repo in ${all_custom_repos[@]}; do
      (
        cd "$repo"
        echo "Updating $(basename $repo)..."
        git pull -q
      ) &

      # Limit number of background processes
      if [[ $(jobs -p | wc -l) -ge $ZSH_CUSTOM_UPDATE_WORKERS ]]; then
        wait -n
      fi
    done

    # Check for Oh My Zsh update
    (
      echo "Updating Oh My Zsh..."
      cd "$ZSH" && git pull -q
    ) &

    wait
    echo "Updates completed!"
  fi
}

# Manual update function
# ----------------------------------------------
upgrade_custom_plugins() {
  rm -f "$UPDATE_CHECK_FILE"
  custom_plugins_update
}

# Run update in background when shell starts
# ------------------------------------------------------------------
(custom_plugins_update) &>/dev/null &