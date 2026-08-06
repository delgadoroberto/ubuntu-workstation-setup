# Neovim

[Neovim](https://neovim.io/) is a modern, extensible text editor based on Vim.

This guide covers the installation and configuration of Neovim on Ubuntu 26.04 using a Lua-based configuration managed with `lazy.nvim`.

The repository provides a ready-to-use configuration with:

- lazy.nvim
- Catppuccin
- nvim-treesitter
- Lua syntax highlighting
- Vim syntax highlighting
- Vim documentation syntax highlighting
- Bash syntax highlighting

---

## 1. Prerequisites

Before installing the repository configuration, make sure the following dependencies are available:

- Neovim
- Git
- GCC or another supported C compiler
- Build tools required by Treesitter parsers

Install Git and the required build tools:

```bash
sudo apt install -y git build-essential
```

Verify the installation:

```bash
git --version
gcc --version
```

---

## 2. Install Neovim

Install Neovim from the Ubuntu package repositories:

```bash
sudo apt install -y neovim
```

Verify the installed version:

```bash
nvim --version
```

Check which executable is being used:

```bash
command -v nvim
```

If multiple Neovim installations exist, use:

```bash
type -a nvim
```

This helps identify which executable is being used by the shell.

---

## 3. Launch Neovim

Start Neovim:

```bash
nvim
```

To exit Neovim:

```text
:q
```

Press `Enter` after entering the command.

---

## 4. Create the Neovim Configuration Directory

Neovim stores user configuration files under:

```text
~/.config/nvim/
```

Create the directory:

```bash
mkdir -p "$HOME/.config/nvim"
```

Verify:

```bash
ls -la "$HOME/.config/nvim"
```

---

## 5. Install the Repository Configuration

The repository provides the Neovim configuration at:

```text
config/nvim/init.lua
```

From the root of the repository, copy the configuration to the user's Neovim configuration directory:

```bash
cp config/nvim/init.lua "$HOME/.config/nvim/init.lua"
```

Verify:

```bash
ls -l "$HOME/.config/nvim/init.lua"
```

The repository version should be treated as the source-controlled configuration.

---

## 6. Configuration Overview

The repository configuration is written in Lua and uses `lazy.nvim` as the plugin manager.

The configuration currently includes:

### lazy.nvim

`lazy.nvim` is used to install and manage Neovim plugins.

If `lazy.nvim` is not already installed, `init.lua` automatically clones it into Neovim's data directory.

No manual installation is required.

### Catppuccin

[Catppuccin](https://github.com/catppuccin/nvim) provides the color scheme.

The configuration uses:

```text
Mocha
```

with transparent backgrounds enabled.

### nvim-treesitter

[nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) provides syntax-aware highlighting.

The current configuration installs parsers for:

- Lua
- Vim
- Vimdoc
- Bash

The required parsers are installed automatically by the configuration.

---

## 7. First Launch

Start Neovim after copying the configuration:

```bash
nvim
```

During the first launch, `init.lua` will:

1. Bootstrap `lazy.nvim` if it is not installed.
2. Install the configured plugins.
3. Configure the Catppuccin color scheme.
4. Install the configured Treesitter parsers.
5. Enable Treesitter highlighting.

The first launch may take longer than subsequent launches because plugins and parsers need to be installed.

---

## 8. Verify the Configuration

Check the configuration directory from inside Neovim:

```vim
:echo stdpath('config')
```

The expected result is similar to:

```text
/home/USERNAME/.config/nvim
```

Check the location of the configuration file:

```vim
:echo $MYVIMRC
```

The expected result is similar to:

```text
/home/USERNAME/.config/nvim/init.lua
```

---

## 9. Check the Plugin Manager

Inside Neovim, run:

```vim
:Lazy
```

The lazy.nvim interface should display the configured plugins.

The current configuration should include:

- catppuccin
- nvim-treesitter

---

## 10. Check Treesitter

Inside Neovim, open a supported file such as a Lua or Bash file.

For example:

```bash
nvim "$HOME/test.lua"
```

Then check the active Treesitter parser:

```vim
:InspectTree
```

If Treesitter is working correctly, the syntax tree should be displayed.

You can also check the installed parsers with:

```vim
:TSInstallInfo
```

> The exact Treesitter commands may vary depending on the installed version of nvim-treesitter.

---

## 11. Check for Configuration Errors

Run Neovim's health check:

```bash
nvim
```

Then execute:

```vim
:checkhealth
```

Neovim will check different components of the installation and report warnings or errors.

Not every warning indicates a problem with the base installation. Some checks depend on optional external tools or plugins.

---

## 12. Check the Lua Configuration

Neovim can execute Lua directly from its command interface.

Run:

```vim
:lua print("Lua configuration is working")
```

You should see:

```text
Lua configuration is working
```

This confirms that Neovim's Lua runtime is available.

---

## 13. Configure Git to Use Neovim

Git can use Neovim as its default editor.

Configure Git with:

```bash
git config --global core.editor "nvim"
```

Verify:

```bash
git config --global core.editor
```

Expected output:

```text
nvim
```

This configuration is also documented in [Git](07-git.md).

---

## 14. Optional: Create a Shell Alias

If desired, create a shell alias for opening Neovim:

```bash
alias v='nvim'
```

This alias only applies to the current shell session.

For Zsh, add the alias to:

```text
~/.zshrc
```

For Bash, add it to:

```text
~/.bashrc
```

For example:

```bash
echo "alias v='nvim'" >> "$HOME/.zshrc"
```

Reload the configuration:

```bash
source "$HOME/.zshrc"
```

Test the alias:

```bash
v
```

---

## 15. Configuration File Structure

The repository uses the following structure:

```text
ubuntu-workstation-setup/
├── config/
│   ├── nvim/
│   │   └── init.lua
│   └── wezterm.lua
└── docs/
    ├── 08-wezterm.md
    └── 09-neovim.md
```

The repository configuration is stored at:

```text
config/nvim/init.lua
```

The active configuration on the workstation is:

```text
~/.config/nvim/init.lua
```

The relationship is:

```text
Repository
    │
    │ copy
    ▼
~/.config/nvim/init.lua
```

The repository version should be treated as the source-controlled configuration.

---

## 16. Update the Repository Configuration

If you modify the active configuration and want to save the changes to the repository, copy it back:

```bash
cp "$HOME/.config/nvim/init.lua" config/nvim/init.lua
```

Review the changes:

```bash
git diff -- config/nvim/init.lua
```

If the changes are correct, commit them through the normal Git workflow.

---

## 17. Backup the Existing Configuration

If a previous Neovim configuration already exists, create a backup before replacing it:

```bash
cp "$HOME/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua.backup"
```

Then copy the repository configuration:

```bash
cp config/nvim/init.lua "$HOME/.config/nvim/init.lua"
```

If you need to restore the backup:

```bash
mv "$HOME/.config/nvim/init.lua.backup" "$HOME/.config/nvim/init.lua"
```

---

## 18. Troubleshooting

### `nvim: command not found`

Check whether Neovim is installed:

```bash
apt policy neovim
```

If it is not installed:

```bash
sudo apt install -y neovim
```

Then verify:

```bash
nvim --version
```

---

### Configuration file is not being loaded

Check the configuration directory:

```vim
:echo stdpath('config')
```

Verify that the file exists:

```bash
ls -la "$HOME/.config/nvim/"
```

Expected:

```text
init.lua
```

---

### lazy.nvim is not installed

Start Neovim:

```bash
nvim
```

Check for errors:

```vim
:messages
```

Verify that Git is available:

```bash
git --version
```

The configuration requires Git to clone lazy.nvim during the bootstrap process.

---

### Plugins are not installed

Inside Neovim, run:

```vim
:Lazy
```

You can also synchronize the configured plugins with:

```vim
:Lazy sync
```

Then restart Neovim.

---

### Treesitter parser installation fails

Make sure the required build tools are installed:

```bash
sudo apt install -y build-essential
```

Verify GCC:

```bash
gcc --version
```

Then restart Neovim and allow the configured Treesitter parsers to install.

---

### Lua configuration errors

Start Neovim:

```bash
nvim
```

Check for errors:

```vim
:messages
```

Run:

```vim
:checkhealth
```

Then inspect the configuration:

```bash
nvim "$HOME/.config/nvim/init.lua"
```

Fix the reported Lua syntax or configuration errors.

---

### `nvim` uses a different version than expected

Check the executable:

```bash
command -v nvim
```

Then:

```bash
nvim --version
```

If multiple installations exist:

```bash
type -a nvim
```

This can reveal whether Neovim is being provided by multiple locations.

---

## 19. Verify the Complete Installation

Check the Neovim version:

```bash
nvim --version
```

Check the executable:

```bash
command -v nvim
```

Check the configuration directory:

```bash
nvim --headless +'lua print(vim.fn.stdpath("config"))' +q
```

Expected output should point to:

```text
/home/USERNAME/.config/nvim
```

Verify that the configuration file exists:

```bash
test -f "$HOME/.config/nvim/init.lua" && echo "init.lua exists"
```

Run a headless health check:

```bash
nvim --headless "+checkhealth" "+quit"
```

---

## Configuration Summary

The Neovim setup consists of:

```text
Neovim
├── Installed
├── Version verified
├── Git installed
├── Build tools installed
├── ~/.config/nvim/ created
├── init.lua configured
├── lazy.nvim bootstrapped
├── Plugins installed
├── Treesitter parsers installed
├── Lua configuration verified
└── Health check performed
```

The repository configuration is stored at:

```text
config/nvim/init.lua
```

The active user configuration is:

```text
~/.config/nvim/init.lua
```

Once Neovim is installed and configured, continue with [VirtualBox](10-virtualbox.md).
