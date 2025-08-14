# 🏠 Dotfiles

This repository contains my dotfiles. These configurations are for my personal development environment for Arch Linux.

## ✨ Features

- **Shell**: Zsh with Oh My Zsh framework and modern plugins
- **File Navigation**: Enhanced with `lsd`, `ripgrep` `bat`, `fd`, and `zoxide`
- **Performance**: Optimized Chrome for using hardware acceleration and Wayland

## 🚀 Quick Setup

### Installation

1. **Install GNU Stow**
2. **Clone this repository**
3. **Backup existing configurations (recommended)**
4. **Apply configurations:**

   ```bash
   stow .
   ```

5. **Install dependencies:**

   ```bash
   # Install Oh My Zsh
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

   # Install all required packages
   yay -S fzf zsh-autopair zsh-autosuggestions zsh-history-substring-search \
          fast-syntax-highlighting starship zoxide bat ripgrep xcp fd pnpm \
          1password btop lsd nvim lazygit cava ghostty mpv
   ```

6. **Restart your shell or source the configuration:**

## 🔧 Managing Configurations

### Adding New Dotfiles

1. **Create the directory structure:**

   ```bash
   mkdir -p ~/.dotfiles/.config/new-app
   ```

2. **Move your configuration:**

   ```bash
   mv ~/.config/new-app/config ~/.dotfiles/.config/new-app/
   ```

3. **Apply with Stow:**

   ```bash
   cd ~/.dotfiles
   stow .
   ```

### Updating Configurations

Simply edit the files in `~/.dotfiles/` and they'll be reflected immediately due to Stow's symlink system.

### Removing Configurations

```bash
cd ~/.dotfiles
stow -D .  # Remove all symlinks
```

---
