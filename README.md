# Dotfiles

My personal dotfiles managed with GNU Stow.

## Contents

- `.zshrc` - Zsh shell
- `.nethackrc`
- `.config/`
  - `cava/` - Audio visualizer
  - `paru/` - AUR helper
  - `yay/` - AUR helper
  - `ghostty/` - Terminal emulator
  - `mpv/` - Media player
  - `starship.toml` - Shell prompt
  - `chrome-flags.conf` - Chrome flags
  - `code-flags.conf` - VS Code flags
- `.oh-my-zsh/` - Oh My Zsh framework

## Restore Your Configs

1. Install GNU Stow:

   ```bash
   yay -S stow
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

4. Install dependencies:

   ```bash
   # Oh My Zsh
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

   # Other dependencies
   yay -S fzf zsh-autopair zsh-autosuggestions zsh-history-substring-search fast-syntax-highlighting starship zoxide bat xcp fd pnpm bitwarden btop lsd nvim lazygit
   ```

## Add a New File

1. Create a folder in your `.dotfiles` directory.
2. Move your configuration file to the newly created folder.
3. Run `stow .` inside the `.dotfiles` directory to create the symlink.
