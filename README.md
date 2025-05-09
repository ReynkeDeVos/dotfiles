# Dotfiles

My personal dotfiles managed with GNU Stow.

## Contents

- `.zshrc` - Zsh shell configuration with Oh My Zsh
- `.nethackrc` - NetHack configuration
- `.config/` - Application-specific configurations
  - `starship.toml` - Starship prompt configuration
  - `ghostty/` - Ghostty terminal emulator configuration
  - `mpv/` - MPV media player configuration
  - `code-flags.conf` - VS Code flags configuration
  - `chrome-flags.conf` - Chrome/Chromium flags configuration

## Installation

1. Install GNU Stow:

   ```bash
   sudo pacman -S stow
   ```

2. Clone this repository:

   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

3. Stow the configurations:
   ```bash
   stow .
   ```

## Dependencies

```bash
# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Starship prompt
curl -sS https://starship.rs/install.sh | sh

# Other dependencies
sudo pacman -S fzf zsh-autopair zsh-autosuggestions fast-syntax-highlighting
```
