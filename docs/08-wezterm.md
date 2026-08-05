# WezTerm

[WezTerm](https://wezfurlong.org/wezterm/) is a modern, GPU-accelerated terminal emulator with support for tabs, panes, multiplexing, SSH, and Lua-based configuration.

This guide covers the installation and basic configuration of WezTerm on Ubuntu 26.04.

---

## 1. Install WezTerm

WezTerm is not installed from the standard Ubuntu package repository in this guide.

Download and install the official WezTerm package for Ubuntu from the WezTerm project.

Before installing a package downloaded from an external source, verify that it is intended for your Ubuntu release and architecture.

After downloading the appropriate `.deb` package, install it with:

```bash
sudo apt install ./wezterm-*.deb
```

APT will automatically resolve the required dependencies.

> The exact WezTerm package filename and version will change as new releases are published. Avoid hard-coding a specific version in this documentation.

---

## 2. Verify the Installation

Check the installed WezTerm version:

```bash
wezterm --version
```

You can also verify the executable location:

```bash
which wezterm
```

Display the available command-line options:

```bash
wezterm --help
```

---

## 3. Create the WezTerm Configuration Directory

WezTerm looks for its configuration in the user's configuration directory.

Create the directory if it does not already exist:

```bash
mkdir -p "$HOME/.config/wezterm"
```

The main configuration file used by this repository is:

```text
~/.config/wezterm/wezterm.lua
```

---

## 4. Copy the Repository Configuration

This repository includes a sample configuration at:

```text
configs/wezterm/wezterm.lua
```

From the root of the cloned repository, copy the configuration file:

```bash
cp configs/wezterm/wezterm.lua "$HOME/.config/wezterm/wezterm.lua"
```

Verify that the file exists:

```bash
ls -l "$HOME/.config/wezterm/wezterm.lua"
```

---

## 5. Create the Configuration Manually

If you prefer to create or customize the configuration manually, open:

```bash
nvim "$HOME/.config/wezterm/wezterm.lua"
```

Alternatively, use another editor:

```bash
nano "$HOME/.config/wezterm/wezterm.lua"
```

A minimal WezTerm configuration can look like:

```lua
local wezterm = require("wezterm")

local config = {}

config.font_size = 11.0
config.enable_tab_bar = true
config.window_close_confirmation = "NeverPrompt"

return config
```

The configuration is written in Lua.

---

## 6. Understand the Configuration File

The repository configuration should be treated as a starting point that can be customized for the workstation.

Common configuration areas include:

- Font
- Font size
- Window appearance
- Window padding
- Tab bar
- Cursor
- Colors
- Keyboard shortcuts
- Mouse behavior
- Shell
- Multiplexing
- Launch configuration

Avoid adding large amounts of configuration unless there is a specific reason for it.

A simple configuration is easier to maintain and troubleshoot.

---

## 7. Validate the WezTerm Configuration

WezTerm provides a configuration check command:

```bash
wezterm check
```

If the configuration is valid, WezTerm should not report configuration errors.

If an error is reported, inspect:

```text
~/.config/wezterm/wezterm.lua
```

Common problems include:

- Lua syntax errors
- Invalid configuration options
- Missing Lua modules
- Incorrect values
- Typographical errors

---

## 8. Launch WezTerm

Launch WezTerm from the desktop application menu or from an existing terminal:

```bash
wezterm
```

You can also start a new WezTerm window with:

```bash
wezterm start
```

---

## 9. Reload the Configuration

After changing `wezterm.lua`, the configuration can be reloaded without completely restarting WezTerm.

Use the default reload configuration action available in WezTerm.

If you have configured a custom key binding for reloading the configuration, use that key combination.

Alternatively, close and reopen the WezTerm window to ensure that the configuration is loaded again.

---

## 10. Configure WezTerm as the Default Terminal

If you want WezTerm to be the default terminal application, configure it through the Ubuntu desktop environment or your preferred desktop settings.

You can check the current default terminal configuration with:

```bash
gsettings get org.gnome.desktop.default-applications.terminal exec
```

Depending on the Ubuntu and GNOME configuration, this key may not be available or may not control the terminal application used by every desktop component.

For this reason, configuring the default terminal through the desktop environment is preferred over modifying unrelated system configuration files.

---

## 11. Useful WezTerm Commands

Display the installed version:

```bash
wezterm --version
```

Display command help:

```bash
wezterm --help
```

Start a new terminal:

```bash
wezterm start
```

Start a new tab:

```bash
wezterm cli spawn --new-window
```

List available CLI commands:

```bash
wezterm cli --help
```

---

## 12. Configuration File Location

The main configuration file is:

```text
~/.config/wezterm/wezterm.lua
```

The repository copy is:

```text
configs/wezterm/wezterm.lua
```

The relationship between the two files is:

```text
ubuntu-workstation-setup/
└── configs/
    └── wezterm/
        └── wezterm.lua
                │
                │ copy
                ▼
~/.config/wezterm/
└── wezterm.lua
```

The repository version should be treated as the source-controlled configuration.

Changes made directly to:

```text
~/.config/wezterm/wezterm.lua
```

will not automatically update the repository copy.

---

## 13. Updating the Repository Configuration

If you make a change to the local configuration and want to keep it in the repository, copy it back into the repository:

```bash
cp "$HOME/.config/wezterm/wezterm.lua" configs/wezterm/wezterm.lua
```

Review the change:

```bash
git diff -- configs/wezterm/wezterm.lua
```

Then commit it through the normal Git workflow.

---

## 14. Troubleshooting

### WezTerm command not found

Check whether the executable is available:

```bash
which wezterm
```

If nothing is returned, verify that the package was installed successfully.

Check the package installation:

```bash
apt policy wezterm
```

If WezTerm was installed from an external `.deb` package, verify that the package installation completed without errors.

---

### Configuration file is not being loaded

Verify the file location:

```bash
ls -la "$HOME/.config/wezterm/"
```

Expected:

```text
wezterm.lua
```

Check the configuration:

```bash
wezterm check
```

Also make sure the file is readable:

```bash
test -r "$HOME/.config/wezterm/wezterm.lua" && echo "Configuration file is readable"
```

---

### Configuration errors

If WezTerm reports a Lua or configuration error, inspect the configuration:

```bash
wezterm check
```

Then review:

```bash
nvim "$HOME/.config/wezterm/wezterm.lua"
```

Fix the reported error and run the check again.

---

## 15. Verify the Installation

Run the following commands:

```bash
wezterm --version
```

```bash
which wezterm
```

```bash
wezterm check
```

Verify the configuration file:

```bash
ls -l "$HOME/.config/wezterm/wezterm.lua"
```

If all checks complete successfully, WezTerm is installed and configured.

---

## Configuration Summary

The WezTerm setup consists of:

```text
WezTerm
├── Installed
├── Version verified
├── ~/.config/wezterm/ created
├── wezterm.lua installed
├── Configuration validated
└── Application tested
```

The repository configuration is stored at:

```text
configs/wezterm/wezterm.lua
```

The active user configuration is:

```text
~/.config/wezterm/wezterm.lua
```

Once WezTerm is installed and configured, continue with [Neovim](09-neovim.md).
