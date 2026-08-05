# Neovim

[Neovim](https://neovim.io/) is a modern, extensible text editor based on Vim.

This guide covers the installation and basic configuration of Neovim on Ubuntu 26.04, including a Lua-based configuration.

---

## 1. Install Neovim

Ubuntu provides Neovim through its package repositories.

Install it with:

```bash
sudo apt install -y neovim
```

---

## 2. Verify the Installation

Check the installed version:

```bash
nvim --version
```

The first line should display the installed Neovim version.

You can also verify the executable location:

```bash
which nvim
```

Check the executable being used:

```bash
command -v nvim
```

---

## 3. Launch Neovim

Start Neovim:

```bash
nvim
```

You should see the Neovim interface.

To exit Neovim:

```text
:q
```

Press `Enter` after entering the command.

---

## 4. Create the Neovim Configuration Directory

Neovim stores its user configuration under:

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

## 5. Create the Lua Configuration

Neovim's primary configuration file can be written in Lua.

Create:

```text
~/.config/nvim/init.lua
```

Using Neovim:

```bash
nvim "$HOME/.config/nvim/init.lua"
```

A minimal configuration can be:

```lua
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true
vim.opt.termguicolors = true
```

Save the file and restart Neovim.

---

## 6. Use the Repository Configuration

This repository can store the Neovim configuration under:

```text
configs/nvim/init.lua
```

From the root of the repository, copy the configuration:

```bash
cp configs/nvim/init.lua "$HOME/.config/nvim/init.lua"
```

Verify the file:

```bash
ls -l "$HOME/.config/nvim/init.lua"
```

---

## 7. Create the Configuration Manually

If you prefer to create the configuration yourself, open:

```bash
nvim "$HOME/.config/nvim/init.lua"
```

A basic configuration can include:

```lua
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true

vim.opt.termguicolors = true
vim.opt.cursorline = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.splitbelow = true
vim.opt.splitright = true
```

These settings provide basic editor behavior without requiring external plugins.

---

## 8. Verify the Configuration

Start Neovim:

```bash
nvim
```

Inside Neovim, check the current configuration directory:

```vim
:echo stdpath('config')
```

The expected result is:

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

## 9. Check for Configuration Errors

Run Neovim with the health check:

```bash
nvim
```

Then execute:

```vim
:checkhealth
```

Neovim will check different parts of the installation and report warnings or errors.

Not every warning indicates a problem with the base installation. Some checks depend on optional external tools or plugins.

---

## 10. Check the Lua Configuration

Neovim can execute Lua directly from its command interface.

For example:

```vim
:lua print("Lua configuration is working")
```

You should see:

```text
Lua configuration is working
```

This confirms that Neovim's Lua runtime is available.

---

## 11. Configure the Default Editor

Git can use Neovim as its default editor.

Configure Git with:

```bash
git config --global core.editor "nvim"
```

Verify:

```bash
git config --global core.editor
```

Expected:

```text
nvim
```

This configuration is also documented in [Git](07-git.md).

---

## 12. Create a Basic Editor Alias

If desired, create a shell alias for opening Neovim:

```bash
alias v='nvim'
```

This alias only applies to the current shell session.

To make it persistent, add it to the appropriate shell configuration file.

For Bash:

```bash
nvim "$HOME/.bashrc"
```

Add:

```bash
alias v='nvim'
```

Reload the configuration:

```bash
source "$HOME/.bashrc"
```

Test:

```bash
v
```

> If you use a different shell, such as Zsh or Fish, configure the alias in that shell's configuration file instead.

---

## 13. Configuration File Structure

The repository configuration can use the following structure:

```text
ubuntu-workstation-setup/
└── configs/
    └── nvim/
        └── init.lua
```

The active configuration on the workstation is:

```text
~/.config/nvim/
└── init.lua
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

## 14. Update the Repository Configuration

If you modify the active configuration and want to save the changes to the repository, copy it back:

```bash
cp "$HOME/.config/nvim/init.lua" configs/nvim/init.lua
```

Review the changes:

```bash
git diff -- configs/nvim/init.lua
```

If the changes are correct, commit them through the normal Git workflow.

---

## 15. Optional: Create a Backup Before Replacing the Configuration

If a previous Neovim configuration already exists, create a backup before replacing it:

```bash
cp "$HOME/.config/nvim/init.lua" "$HOME/.config/nvim/init.lua.backup"
```

Then copy the repository configuration:

```bash
cp configs/nvim/init.lua "$HOME/.config/nvim/init.lua"
```

If you need to restore the backup:

```bash
mv "$HOME/.config/nvim/init.lua.backup" "$HOME/.config/nvim/init.lua"
```

---

## 16. Troubleshooting

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

Check the configuration directory from inside Neovim:

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
which nvim
```

Then:

```bash
nvim --version
```

If multiple installations exist, check all available executables:

```bash
type -a nvim
```

This can reveal whether Neovim is being provided by multiple locations.

---

## 17. Verify the Complete Installation

Check the version:

```bash
nvim --version
```

Check the executable:

```bash
which nvim
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
├── ~/.config/nvim/ created
├── init.lua configured
├── Lua configuration verified
└── Health check performed
```

The repository configuration is stored at:

```text
configs/nvim/init.lua
```

The active user configuration is:

```text
~/.config/nvim/init.lua
```

Once Neovim is installed and configured, continue with [VirtualBox](10-virtualbox.md).
