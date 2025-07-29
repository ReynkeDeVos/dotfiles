# 🏠 Dotfiles

> My personal development environment configuration files for Arch Linux

This repository contains my dotfiles. These configurations provide a modern and efficient development environment.

## ✨ Features

- **Shell**: Zsh with Oh My Zsh framework and modern plugins
- **File Navigation**: Enhanced with `lsd`, `bat`, `fd`, and `zoxide`
- **Performance**: Optimized Chrome and VS Code flags

## 📁 Structure

```txt
~/.dotfiles/
├── .zshrc                  # Zsh shell configuration
├── .nethackrc              # NetHack game settings
├── .config/
│   ├── cava/               # Audio visualizer config
│   ├── paru/               # AUR helper settings
│   ├── yay/                # AUR helper settings
│   ├── ghostty/            # Terminal emulator config
│   ├── mpv/                # Media player settings
│   ├── starship.toml       # Shell prompt configuration
│   ├── chrome-flags.conf   # Chrome optimization flags
│   └── code-flags.conf     # VS Code optimization flags
└── .oh-my-zsh/             # Oh My Zsh framework
```

## 🚀 Quick Setup

### Prerequisites

- Arch Linux (or Arch-based distribution)
- Git
- An AUR helper (yay/paru will be installed if not present)

### Installation

1. **Install GNU Stow:**

   ```bash
   sudo pacman -S stow
   ```

2. **Clone this repository:**

   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

3. **Backup existing configurations (recommended):**

   ```bash
   mkdir -p ~/.config-backup
   cp -r ~/.config/* ~/.config-backup/ 2>/dev/null || true
   cp ~/.zshrc ~/.config-backup/ 2>/dev/null || true
   ```

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
          fast-syntax-highlighting starship zoxide bat xcp fd pnpm \
          bitwarden btop lsd nvim lazygit cava ghostty mpv
   ```

6. **Restart your shell or source the configuration:**

```bash
  source ~/.zshrc
```

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

**Note:** Remember to update the repository URL in the clone command with your actual GitHub username!
