# Neovim Configuration

## Requirements

- **Neovim** >= 0.12.0
- **Git** for plugin management
- **Node.js** >= 16 (for JavaScript/TypeScript tools)

## Installation

1. **Install Plug Nvim**:
    Linux:
    ```bash
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    ```

    for Windows:
    ```powershell
    iwr -useb https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim |`
    ni "$(@($env:XDG_DATA_HOME, $env:LOCALAPPDATA)[$null -eq $env:XDG_DATA_HOME])/nvim-data/site/autoload/plug.vim" -Force
    ```

2. **Clone this repository**:
   ```bash
   git clone https://github.com/i0i-i0i/init.lua ~/.config/nvim
   ```

3. **Install plugins**:
   Launch Neovim and run:
   ```vim
   :PlugInstall
   ```

3. **Mason LSP servers** will be automatically installed on first use
