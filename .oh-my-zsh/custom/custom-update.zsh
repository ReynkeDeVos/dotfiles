#!/usr/bin/env zsh
#
# Custom Update System for Oh My Zsh and Custom Plugins
#

# Configuration
# ----------------------------------------------

# Prevent job control messages
setopt NO_MONITOR

# Update frequency in days
ZSH_CUSTOM_UPDATE_DAYS=7

# Maximum parallel workers for git operations
ZSH_CUSTOM_UPDATE_WORKERS=4

# Path to update timestamp file
UPDATE_CHECK_FILE="$HOME/.zsh_update_check"

# Main update function
# -------------------
custom_plugins_update() {
  # Check if file doesn't exist or is older than ZSH_CUSTOM_UPDATE_DAYS
  if [[ ! -f $UPDATE_CHECK_FILE ]] || [[ $(find "$UPDATE_CHECK_FILE" -mtime +$ZSH_CUSTOM_UPDATE_DAYS -print) ]]; then
    # Touch file to mark last check time
    touch "$UPDATE_CHECK_FILE"
    
    # Optional: Remove this if you prefer completely silent updates
    echo "Checking for updates to Oh My Zsh and custom plugins..."
    
    # Get all custom plugin and theme directories
    custom_plugins=($ZSH_CUSTOM/plugins/*/.git)
    custom_plugins=("${custom_plugins[@]%/*}")
    custom_themes=($ZSH_CUSTOM/themes/*/.git)
    custom_themes=("${custom_themes[@]%/*}")
    
    # Combined list of all custom git repositories
    all_custom_repos=(${custom_plugins[@]} ${custom_themes[@]})
    
    # Update in parallel with workers
    for repo in ${all_custom_repos[@]}; do
      # Update in background, limit jobs to ZSH_CUSTOM_UPDATE_WORKERS
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
    
    # Wait for all background processes to finish
    wait
    
    echo "Updates completed!"
  fi
}

# Manual update function (can be called directly)
# ----------------------------------------------
upgrade_custom_plugins() {
  # Force update regardless of timestamp
  rm -f "$UPDATE_CHECK_FILE"
  custom_plugins_update
}

# Update in background when shell starts 
# (remove the & at the end if you prefer to see the update happening)
# ------------------------------------------------------------------
(custom_plugins_update) &>/dev/null &