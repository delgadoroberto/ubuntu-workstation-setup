# WezTerm

[WezTerm](https://wezterm.org/) is a modern, GPU-accelerated terminal emulator with support for tabs, panes, multiplexing, SSH, and Lua-based configuration.

This guide covers the installation and basic configuration of WezTerm on Ubuntu 26.04 using the official WezTerm APT repository.

---

## 1. Install WezTerm

WezTerm provides an official APT repository for Debian-based systems.

Using the APT repository is preferred over manually downloading a `.deb` package because APT can manage the package and its updates.

### Add the WezTerm GPG Key

Download and install the repository signing key:

```bash
curl -fsSL https://apt.fury.io/wez/gpg.key | \
  sudo gpg --yes --dearmor \
  -o /usr/share/keyrings/wezterm-fury.gpg
```

Set the appropriate permissions on the keyring:

```bash
sudo chmod 644 /usr/share/keyrings/wezterm-fury.gpg
```

### Add the WezTerm Repository

Create the APT repository configuration:

```bash
echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | \
  sudo tee /etc/apt/sources.list.d/wezterm.list
```

Update the package index:

```bash
sudo apt update
```

Install WezTerm:

```bash
sudo apt install -y wezterm
```

> These commands follow the official WezTerm Linux installation instructions. :contentReference[oaicite:2]{index=2}

---

## 2. Verify the Installation

Check the installed WezTerm version:

```bash
wezterm --version
```

Verify the executable:

```bash
which wezterm
```

Display the available command-line options:

```bash
wezterm --help
```

Check the installed package:

```bash
apt policy wezterm
```

---

## 3. Verify the Man Page

The native package installation should provide the WezTerm documentation available through the system's manual page infrastructure.

Check the manual page:

```bash
man wezterm
```

You can also search the manual database:

```bash
man -k wezterm
```

If the manual page is available, the installation is correctly integrated with the system's `man` infrastructure.

To exit the manual page:

```text
q
```

> If `man wezterm` does not work, verify that the `wezterm` package was installed correctly and that the system's manual page infrastructure is available.

You can verify the package contents with:

```bash
dpkg -L wezterm | grep -E '/man/|wezterm\.1'
```

---

## 4. Create the WezTerm Configuration Directory

WezTerm uses a Lua configuration file.

Create the configuration directory:

```bash
mkdir -p "$HOME/.config/wezterm"
```

The active configuration file used by this repository is:

```text
~/.config/wezterm/wezterm.lua
```

---

## 5. Copy the Repository Configuration

This repository provides a baseline WezTerm configuration at:

```text
configs/wezterm/wezterm.lua
```

From the root of the cloned repository, copy the configuration:

```bash
cp configs/wezterm/wezterm.lua \
  "$HOME/.config/wezterm/wezterm.lua"
```

Verify that the file exists:

```bash
ls -l "$HOME/.config/wezterm/wezterm.lua"
```

Verify that it is readable:

```bash
test -r "$HOME/.config/wezterm/wezterm.lua" && \
  echo "WezTerm configuration is readable"
```

---

## 6. Configuration

The repository configuration is the source-controlled configuration for this workstation setup.

The configuration file is:

```text
configs/wezterm/wezterm.lua
```

The active user configuration is:

```text
~/.config/wezterm/wezterm.lua
```

WezTerm configuration files use Lua.

The configuration can be customized according to the workstation's requirements.

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

> Keep the repository configuration reasonably minimal. A smaller configuration is easier to maintain and troubleshoot.

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

You can open it with Neovim:

```bash
nvim "$HOME/.config/wezterm/wezterm.lua"
```

Or with another editor:

```bash
nano "$HOME/.config/wezterm/wezterm.lua"
```

Common problems include:

- Lua syntax errors
- Invalid configuration options
- Incorrect values
- Typographical errors
- Unsupported configuration options

---

## 8. Launch WezTerm

Launch WezTerm from the Ubuntu application menu or from an existing terminal:

```bash
wezterm
```

You can also explicitly start a new WezTerm window:

```bash
wezterm start
```

---

## 9. Reload the Configuration

WezTerm supports configuration reloads without requiring a complete application restart.

If the configuration is modified while WezTerm is running, use the default reload configuration action.

You can also close and reopen the WezTerm window to ensure that the updated configuration is loaded.

For advanced configurations, a custom key binding can be added to reload the configuration.

---

## 10. Configure WezTerm as the Default Terminal

If you want WezTerm to be the default terminal application, configure it through the Ubuntu desktop environment or the appropriate GNOME settings.

You can check the current terminal configuration with:

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

Display available fonts:

```bash
wezterm ls-fonts
```

Display available key assignments:

```bash
wezterm show-keys
```

List available CLI commands:

```bash
wezterm cli --help
```

The exact command-line options depend on the installed WezTerm version. Use:

```bash
wezterm --help
```

for the authoritative list of commands supported by the installed version. :contentReference[oaicite:3]{index=3}

---

## 12. Configuration File Location

The repository configuration is:

```text
configs/wezterm/wezterm.lua
```

The active user configuration is:

```text
~/.config/wezterm/wezterm.lua
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

If you modify the local configuration and want to keep the changes in the repository, copy it back:

```bash
cp "$HOME/.config/wezterm/wezterm.lua" \
  configs/wezterm/wezterm.lua
```

Review the changes:

```bash
git diff -- configs/wezterm/wezterm.lua
```

Check the repository status:

```bash
git status
```

Then commit the configuration through the normal Git workflow.

---

## 14. Updating WezTerm

Because WezTerm was installed from an APT repository, updates can be managed through APT.

Refresh the package index:

```bash
sudo apt update
```

Check whether an update is available:

```bash
apt list --upgradable 2>/dev/null | grep wezterm
```

Upgrade WezTerm:

```bash
sudo apt install --only-upgrade wezterm
```

Verify the installed version:

```bash
wezterm --version
```

---

## 15. Troubleshooting

### WezTerm command not found

Check whether the executable is available:

```bash
which wezterm
```

Check the package:

```bash
apt policy wezterm
```

If the package is not installed:

```bash
sudo apt update
sudo apt install -y wezterm
```

---

### `man wezterm` does not work

First verify the package:

```bash
apt policy wezterm
```

Verify that the package is installed:

```bash
dpkg -l wezterm
```

Check whether the package contains a manual page:

```bash
dpkg -L wezterm | grep -E '/man/|wezterm\.1'
```

Then try:

```bash
man wezterm
```

Also verify that the `man` command is available:

```bash
command -v man
```

If necessary, verify the manual page database:

```bash
man -w wezterm
```

If the package installation appears incomplete, reinstall it:

```bash
sudo apt install --reinstall wezterm
```

Then test again:

```bash
man wezterm
```

---

### Configuration file is not being loaded

Verify the configuration directory:

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

Verify that the file is readable:

```bash
test -r "$HOME/.config/wezterm/wezterm.lua" && \
  echo "Configuration file is readable"
```

---

### Configuration errors

Run:

```bash
wezterm check
```

Then review:

```bash
nvim "$HOME/.config/wezterm/wezterm.lua"
```

Fix the reported error and run the check again.

---

### APT repository problems

Check the repository configuration:

```bash
cat /etc/apt/sources.list.d/wezterm.list
```

Expected:

```text
deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *
```

Check the repository signing key:

```bash
ls -l /usr/share/keyrings/wezterm-fury.gpg
```

Update the package index:

```bash
sudo apt update
```

If APT reports an error, read the exact error message before making additional repository changes.

Do not add duplicate WezTerm repositories or download unrelated repository keys.

---

## 16. Verify the Installation

Run:

```bash
wezterm --version
```

Verify the executable:

```bash
which wezterm
```

Check the package:

```bash
apt policy wezterm
```

Validate the configuration:

```bash
wezterm check
```

Verify the configuration file:

```bash
ls -l "$HOME/.config/wezterm/wezterm.lua"
```

Verify the manual page:

```bash
man -w wezterm
```

If all relevant checks complete successfully, WezTerm is installed and configured.

---

## Configuration Summary

The WezTerm setup consists of:

```text
WezTerm
├── Official APT repository configured
├── GPG signing key installed
├── Package installed
├── Version verified
├── Man page verified
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
