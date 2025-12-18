# -------------------------------------------------------------------------
# screensaver - Interactive terminal screensaver selector
# Choose between asciiquarium, neo-matrix, hollywood, and genact
# -------------------------------------------------------------------------

function screensaver() {
  emulate -L zsh
  setopt localoptions no_aliases

  # Main menu: select screensaver
  echo "Select a screensaver:"
  echo "  1) asciiquarium"
  echo "  2) neo-matrix"
  echo "  3) hollywood"
  echo "  4) genact"
  echo -n "Enter choice [1-4]: "
  read -r choice

  case "$choice" in
    1)
      _screensaver_asciiquarium
      ;;
    2)
      _screensaver_neomatrix
      ;;
    3)
      _screensaver_hollywood
      ;;
    4)
      _screensaver_genact
      ;;
    *)
      echo "Invalid choice."
      return 1
      ;;
  esac
}

# asciiquarium options
function _screensaver_asciiquarium() {
  if ! command -v asciiquarium >/dev/null 2>&1; then
    echo "✖ asciiquarium not found. Please install it first." >&2
    return 127
  fi

  echo ""
  echo "asciiquarium options:"
  echo "  1) With rainbow colors (asciiquarium | lolcat)"
  echo -n "Enter option (or press Enter for default): "
  read -r option

  if [[ -z "$option" ]]; then
    # Default: standard asciiquarium
    asciiquarium
  else
    case "$option" in
      1)
        if ! command -v lolcat >/dev/null 2>&1; then
          echo "✖ lolcat not found. Running without colors." >&2
          asciiquarium
        else
          asciiquarium | lolcat
        fi
        ;;
      *)
        echo "Invalid choice."
        return 1
        ;;
    esac
  fi
}

# neo-matrix options
function _screensaver_neomatrix() {
  if ! command -v neo-matrix >/dev/null 2>&1; then
    echo "✖ neo-matrix not found. Please install it first." >&2
    return 127
  fi

  echo ""
  echo "neo-matrix options:"
  echo "  1) Cyberpunk Cyan (dark background, cyan/blue gradient)"
  echo "  2) Purple Dream (dark purple background, purple/violet gradient)"
  echo "  3) Amber Sunset (dark background, warm orange/amber gradient)"
  echo -n "Enter option (or press Enter for default): "
  read -r option

  if [[ -z "$option" ]]; then
    # Default: default settings
    neo-matrix
  else
    local colorfile
    colorfile=$(mktemp) || { echo "✖ Failed to create temporary file." >&2; return 1; }
    
    case "$option" in
      1)
        # Cyberpunk Cyan: Dark background with bright cyan/blue gradient
        cat > "$colorfile" <<EOF
0
21
27
33
39
45
51
EOF
        neo-matrix -C "$colorfile"
        ;;
      2)
        # Purple Dream: Dark purple background with purple/violet gradient
        cat > "$colorfile" <<EOF
53
54
55
56
57
91
129
EOF
        neo-matrix -C "$colorfile"
        ;;
      3)
        # Amber Sunset: Dark background with warm orange/amber/yellow gradient
        cat > "$colorfile" <<EOF
0
208
209
214
220
226
227
EOF
        neo-matrix -C "$colorfile"
        ;;
      *)
        rm -f "$colorfile"
        echo "Invalid choice."
        return 1
        ;;
    esac
    
    rm -f "$colorfile"
  fi
}

# hollywood options
function _screensaver_hollywood() {
  if ! command -v hollywood >/dev/null 2>&1; then
    echo "✖ hollywood not found. Please install it first." >&2
    return 127
  fi

  echo ""
  echo "hollywood options:"
  echo "  1) Custom delay and splits"
  echo -n "Enter option (or press Enter for default): "
  read -r option

  if [[ -z "$option" ]]; then
    # Default: default settings
    hollywood
  else
    case "$option" in
      1)
        echo -n "Enter delay in seconds (default: 10): "
        read -r delay
        delay="${delay:-10}"
        
        echo -n "Enter number of splits (default: auto): "
        read -r splits
        
        if [[ -n "$splits" && "$splits" =~ ^[0-9]+$ ]]; then
          hollywood -d "$delay" -s "$splits"
        else
          hollywood -d "$delay"
        fi
        ;;
      *)
        echo "Invalid choice."
        return 1
        ;;
    esac
  fi
}

# genact options
function _screensaver_genact() {
  if ! command -v genact >/dev/null 2>&1; then
    echo "✖ genact not found. Please install it first." >&2
    return 127
  fi

  echo ""
  echo "Fetching genact modes..."
  local modes
  modes=$(genact -l 2>/dev/null)
  
  if [[ -z "$modes" ]]; then
    echo "✖ Could not fetch genact modes. Running with default." >&2
    genact
    return 0
  fi

  echo ""
  echo "Available modules:"
  echo "$modes" | nl -w2 -s') '
  echo ""
  echo -n "Enter option (or press Enter for default): "
  read -r mode_choice

  if [[ -z "$mode_choice" ]]; then
    genact
  elif [[ "$mode_choice" =~ ^[0-9]+$ ]]; then
    # User entered a number, extract the mode name
    local mode_name
    mode_name=$(echo "$modes" | sed -n "${mode_choice}p" | awk '{print $1}')
    if [[ -n "$mode_name" ]]; then
      genact -m "$mode_name"
    else
      echo "✖ Invalid mode number." >&2
      return 1
    fi
  else
    # User entered a mode name directly
    genact -m "$mode_choice"
  fi
}

# Convenience alias
alias saver='screensaver'
