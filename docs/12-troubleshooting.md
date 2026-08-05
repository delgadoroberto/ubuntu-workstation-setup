# Troubleshooting

This guide provides troubleshooting procedures for common problems that may occur while configuring an Ubuntu 26.04 workstation using this repository.

The goal is to provide practical diagnostic commands before making system changes.

> Always identify the problem first and collect relevant information before modifying system configuration.

---

## 1. Check the Ubuntu Version

Before troubleshooting a system-specific problem, verify the installed Ubuntu version:

```bash
lsb_release -a
```

You can also use:

```bash
cat /etc/os-release
```

Check the kernel version:

```bash
uname -r
```

Check the system architecture:

```bash
uname -m
```

These commands provide useful information when troubleshooting package, driver, or compatibility problems.

---

## 2. Check Available Disk Space

Many installation problems are caused by insufficient disk space.

Check the available space:

```bash
df -h
```

Pay particular attention to:

```text
/
```

You can also identify large directories:

```bash
sudo du -xh --max-depth=1 / 2>/dev/null | sort -h
```

Check the user's home directory:

```bash
du -xh --max-depth=1 "$HOME" 2>/dev/null | sort -h
```

If disk space is low, review [Cleanup](06-cleanup.md) before deleting files manually.

---

## 3. Check Memory and Swap

Check RAM and swap:

```bash
free -h
```

Check the configured swap:

```bash
swapon --show
```

Check the current swappiness:

```bash
sysctl vm.swappiness
```

The workstation configuration documented in this repository uses:

```text
vm.swappiness = 10
```

If the value is different, check:

```bash
cat /etc/sysctl.d/99-workstation.conf
```

Apply the configuration:

```bash
sudo sysctl --system
```

Then verify:

```bash
sysctl vm.swappiness
```

---

## 4. APT Is Reporting Broken Dependencies

Check the package database:

```bash
sudo apt check
```

If dependency problems are reported, inspect the package manager state before making changes.

You can also run:

```bash
sudo dpkg --configure -a
```

Then:

```bash
sudo apt --fix-broken install
```

Afterward, verify again:

```bash
sudo apt check
```

> Do not repeatedly run repair commands without understanding the reported dependency problem.

---

## 5. APT Cannot Find a Package

If APT reports:

```text
Unable to locate package
```

First update the package index:

```bash
sudo apt update
```

Then search for the package:

```bash
apt search package-name
```

Check whether the package exists:

```bash
apt policy package-name
```

If the package is still unavailable, verify:

- The package name is correct.
- The required Ubuntu repository is enabled.
- The package is available for Ubuntu 26.04.
- The package is compatible with the system architecture.

Check enabled repositories:

```bash
apt policy
```

---

## 6. APT Update Fails

If:

```bash
sudo apt update
```

fails, review the error message carefully.

Common causes include:

- Network connectivity problems
- DNS resolution problems
- Repository server problems
- Invalid repository configuration
- Expired repository metadata
- Incorrect third-party repository configuration

Check network connectivity:

```bash
ping -c 4 1.1.1.1
```

Check DNS resolution:

```bash
getent hosts archive.ubuntu.com
```

Check the configured Ubuntu release:

```bash
lsb_release -cs
```

Do not blindly add repositories from random websites to resolve an APT error.

---

## 7. Check Network Connectivity

Display network interfaces:

```bash
ip addr
```

Display routing information:

```bash
ip route
```

Check connectivity to a known IP:

```bash
ping -c 4 1.1.1.1
```

Check DNS:

```bash
getent hosts ubuntu.com
```

Check the NetworkManager status:

```bash
systemctl status NetworkManager
```

Display NetworkManager device status:

```bash
nmcli device status
```

---

## 8. Git Is Not Working

Check Git:

```bash
git --version
```

Check the configured identity:

```bash
git config --global user.name
```

```bash
git config --global user.email
```

Review the complete configuration:

```bash
git config --global --list --show-origin
```

Check the repository status:

```bash
git status
```

Check the configured remote:

```bash
git remote -v
```

---

## 9. GitHub SSH Authentication Fails

Test the SSH connection:

```bash
ssh -T git@github.com
```

Check whether the SSH key is loaded:

```bash
ssh-add -l
```

If no identities are available, start the SSH agent:

```bash
eval "$(ssh-agent -s)"
```

Then add the key:

```bash
ssh-add ~/.ssh/id_ed25519
```

Verify:

```bash
ssh-add -l
```

Check the public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

Make sure the public key has been added to the correct GitHub account.

Never upload or share:

```text
~/.ssh/id_ed25519
```

Only the `.pub` file should be shared.

---

## 10. WezTerm Is Not Starting

Check whether WezTerm is installed:

```bash
which wezterm
```

Check the version:

```bash
wezterm --version
```

Check the configuration:

```bash
wezterm check
```

Verify the configuration file:

```bash
ls -l "$HOME/.config/wezterm/wezterm.lua"
```

If the configuration is invalid, inspect:

```bash
nvim "$HOME/.config/wezterm/wezterm.lua"
```

Temporarily move the configuration to test whether the problem is configuration-related:

```bash
mv "$HOME/.config/wezterm/wezterm.lua" \
   "$HOME/.config/wezterm/wezterm.lua.backup"
```

Then try:

```bash
wezterm
```

If WezTerm works without the configuration, the problem is likely inside `wezterm.lua`.

Restore the configuration when finished:

```bash
mv "$HOME/.config/wezterm/wezterm.lua.backup" \
   "$HOME/.config/wezterm/wezterm.lua"
```

---

## 11. Neovim Is Not Starting

Check the executable:

```bash
which nvim
```

Check the version:

```bash
nvim --version
```

Check all available Neovim executables:

```bash
type -a nvim
```

Verify the configuration directory:

```bash
nvim --headless +'lua print(vim.fn.stdpath("config"))' +q
```

Check whether the configuration file exists:

```bash
ls -l "$HOME/.config/nvim/init.lua"
```

---

## 12. Neovim Configuration Causes Errors

Start Neovim:

```bash
nvim
```

Display messages:

```vim
:messages
```

Run the health check:

```vim
:checkhealth
```

Check the configuration file:

```bash
nvim "$HOME/.config/nvim/init.lua"
```

To determine whether the configuration itself is causing the problem, temporarily move it:

```bash
mv "$HOME/.config/nvim/init.lua" \
   "$HOME/.config/nvim/init.lua.backup"
```

Start Neovim:

```bash
nvim
```

If Neovim starts normally, the problem is likely inside the configuration file.

Restore the file when finished:

```bash
mv "$HOME/.config/nvim/init.lua.backup" \
   "$HOME/.config/nvim/init.lua"
```

---

## 13. VirtualBox Cannot Start a Virtual Machine

Check the VirtualBox version:

```bash
VBoxManage --version
```

Check virtualization support:

```bash
lscpu | grep -i virtualization
```

Check the user's groups:

```bash
id -nG
```

Verify:

```text
vboxusers
```

is present.

Check VirtualBox kernel modules:

```bash
lsmod | grep -E '^vbox'
```

Check the kernel:

```bash
uname -r
```

Check available disk space:

```bash
df -h
```

---

## 14. `vboxusers` Is Missing

Check the group:

```bash
getent group vboxusers
```

Add the current user:

```bash
sudo usermod -aG vboxusers "$USER"
```

Then log out and log back in.

Alternatively:

```bash
sudo reboot
```

After logging back in:

```bash
id -nG
```

Verify specifically:

```bash
id -nG | grep -qw vboxusers && echo "vboxusers membership confirmed"
```

---

## 15. Bluetooth Is Still Active

Check the service:

```bash
systemctl status bluetooth
```

Check whether it is enabled:

```bash
systemctl is-enabled bluetooth
```

Check whether it is currently active:

```bash
systemctl is-active bluetooth
```

Disable the service:

```bash
sudo systemctl disable bluetooth
```

Stop it:

```bash
sudo systemctl stop bluetooth
```

Verify:

```bash
systemctl is-enabled bluetooth
```

Expected:

```text
disabled
```

And:

```bash
systemctl is-active bluetooth
```

Expected:

```text
inactive
```

If Bluetooth is still available through the desktop interface, check whether another component is managing Bluetooth hardware independently of the service.

---

## 16. UFW Is Not Active

Check the firewall:

```bash
sudo ufw status verbose
```

If it reports:

```text
Status: inactive
```

enable it:

```bash
sudo ufw enable
```

Then verify:

```bash
sudo ufw status verbose
```

Expected:

```text
Status: active
```

---

## 17. UFW Is Blocking a Required Service

First list the current rules:

```bash
sudo ufw status numbered
```

Identify which service or port is being blocked before adding a new rule.

For example, if SSH is intentionally required:

```bash
sudo ufw allow OpenSSH
```

Verify:

```bash
sudo ufw status numbered
```

Avoid opening ports without understanding which application is listening on them.

To inspect listening services:

```bash
sudo ss -tulpn
```

---

## 18. GUFW Does Not Start

Check whether GUFW is installed:

```bash
apt policy gufw
```

Check the executable:

```bash
which gufw
```

Launch it:

```bash
gufw
```

If the application does not start, verify UFW directly:

```bash
sudo ufw status verbose
```

GUFW is only a graphical frontend. The underlying firewall configuration can still be managed through UFW.

---

## 19. ClamAV Scan Fails

Check the installation:

```bash
clamscan --version
```

Check the virus database:

```bash
ls -lh /var/lib/clamav/
```

Update the database:

```bash
sudo freshclam
```

Check the update service:

```bash
systemctl status clamav-freshclam
```

Try scanning a specific directory:

```bash
clamscan -r "$HOME/Downloads"
```

For infected files only:

```bash
clamscan -r --infected "$HOME/Downloads"
```

---

## 20. ClamAV Database Update Is Locked

If `freshclam` reports that the database is already being updated, check the service:

```bash
systemctl status clamav-freshclam
```

If the service is active, allow it to complete its update.

Do not run multiple ClamAV database update processes simultaneously.

---

## 21. GNOME Extension Causes Problems

List installed extensions:

```bash
gnome-extensions list
```

List enabled extensions:

```bash
gnome-extensions list --enabled
```

Disable the problematic extension:

```bash
gnome-extensions disable EXTENSION_UUID
```

Replace:

```text
EXTENSION_UUID
```

with the actual extension UUID.

Inspect it:

```bash
gnome-extensions info EXTENSION_UUID
```

If necessary, uninstall it:

```bash
gnome-extensions uninstall EXTENSION_UUID
```

---

## 22. Check System Services

List failed system services:

```bash
systemctl --failed
```

If a service is listed, inspect it:

```bash
systemctl status SERVICE_NAME
```

Replace:

```text
SERVICE_NAME
```

with the affected service.

View recent logs:

```bash
journalctl -u SERVICE_NAME -b
```

To display only recent messages:

```bash
journalctl -u SERVICE_NAME -b -n 100
```

---

## 23. Check the System Journal

View recent system messages:

```bash
journalctl -b
```

View only errors:

```bash
journalctl -b -p err
```

View errors and warnings:

```bash
journalctl -b -p warning
```

View kernel messages:

```bash
journalctl -k -b
```

These commands can help identify problems involving:

- Hardware
- Drivers
- Services
- Networking
- Storage
- Boot
- Kernel modules

---

## 24. Check Failed Boot Services

Run:

```bash
systemctl --failed
```

If no units are listed, there are no services currently marked as failed.

For a specific failed service:

```bash
systemctl status SERVICE_NAME
```

Then:

```bash
journalctl -u SERVICE_NAME -b
```

Review the error messages before attempting to restart or reinstall the service.

---

## 25. Check Recent Kernel Messages

Display recent kernel messages:

```bash
dmesg --level=err,warn
```

On systems where access is restricted, use:

```bash
sudo dmesg --level=err,warn
```

You can also use:

```bash
journalctl -k -b
```

The journal is generally preferable when investigating systemd and boot-related problems.

---

## 26. Check Running Processes

List processes:

```bash
ps aux
```

Display processes interactively:

```bash
top
```

If installed, you can also use:

```bash
htop
```

Check processes consuming significant CPU or memory resources.

For a quick memory overview:

```bash
free -h
```

For CPU information:

```bash
lscpu
```

---

## 27. Check Listening Network Services

Display listening TCP and UDP sockets:

```bash
sudo ss -tulpn
```

This can help identify applications accepting network connections.

Before opening a firewall port, identify the corresponding process.

Example:

```text
Local Address
Port
Protocol
Process
```

Only expose services that are intentionally required.

---

## 28. Check User Permissions

Display the current user:

```bash
whoami
```

Display user and group information:

```bash
id
```

Display group membership:

```bash
groups
```

Check a file's ownership and permissions:

```bash
ls -l /path/to/file
```

Check directory permissions:

```bash
ls -ld /path/to/directory
```

Avoid changing ownership or permissions recursively unless there is a clear reason.

For example, avoid using broad commands such as:

```bash
sudo chmod -R 777 /path
```

This can create serious security problems.

---

## 29. Check Environment Variables

Display the current environment:

```bash
env
```

Check the current PATH:

```bash
echo "$PATH"
```

Locate a command:

```bash
command -v COMMAND
```

Replace:

```text
COMMAND
```

with the command you are troubleshooting.

For example:

```bash
command -v git
```

or:

```bash
command -v nvim
```

---

## 30. Check Shell Configuration

If a command or alias behaves unexpectedly, check the shell:

```bash
echo "$SHELL"
```

Check the current shell process:

```bash
ps -p $$ -o comm=
```

For Bash, inspect:

```bash
~/.bashrc
```

For example:

```bash
nvim "$HOME/.bashrc"
```

After making changes:

```bash
source "$HOME/.bashrc"
```

---

## 31. General Diagnostic Procedure

When an application or system component fails, use the following sequence.

### Step 1: Identify the Component

Determine exactly what is failing.

Examples:

```text
Git
WezTerm
Neovim
VirtualBox
Bluetooth
UFW
GUFW
ClamAV
GNOME Extensions
```

### Step 2: Check Installation

For APT packages:

```bash
apt policy PACKAGE_NAME
```

### Step 3: Check the Executable

```bash
command -v COMMAND
```

### Step 4: Check the Version

```bash
COMMAND --version
```

### Step 5: Check Configuration

Review the application's configuration files.

### Step 6: Check Logs

For systemd services:

```bash
systemctl status SERVICE_NAME
```

Then:

```bash
journalctl -u SERVICE_NAME -b
```

### Step 7: Reproduce the Problem

Run the affected command again and capture the exact error message.

### Step 8: Make the Smallest Necessary Change

Avoid changing multiple system components simultaneously.

### Step 9: Verify

After making a change, test the affected component again.

---

## 32. Collect System Information

When troubleshooting a complex problem, collect basic system information:

```bash
lsb_release -a
```

```bash
uname -r
```

```bash
uname -m
```

```bash
free -h
```

```bash
df -h
```

```bash
systemctl --failed
```

```bash
ip addr
```

```bash
ip route
```

```bash
sudo ss -tulpn
```

This information can help identify whether the problem is related to the operating system, kernel, resources, networking, services, or applications.

---

## 33. Before Reinstalling Software

Reinstalling software should not be the first troubleshooting step.

Before reinstalling, check:

```bash
apt policy PACKAGE_NAME
```

Then:

```bash
systemctl status SERVICE_NAME
```

if the application provides a systemd service.

Check configuration files and logs.

If the installation is genuinely corrupted and reinstalling is appropriate:

```bash
sudo apt install --reinstall PACKAGE_NAME
```

Replace:

```text
PACKAGE_NAME
```

with the actual package.

Verify the installation afterward.

---

## 34. Final Verification

After resolving a problem, verify the workstation state.

Run:

```bash
sudo apt check
```

Then:

```bash
systemctl --failed
```

Check disk space:

```bash
df -h
```

Check memory:

```bash
free -h
```

Check the firewall:

```bash
sudo ufw status verbose
```

Check swap:

```bash
swapon --show
```

Check swappiness:

```bash
sysctl vm.swappiness
```

Check the current user:

```bash
id
```

---

## Troubleshooting Summary

The most useful commands in this repository are:

### System

```bash
lsb_release -a
```

```bash
uname -r
```

```bash
free -h
```

```bash
df -h
```

### APT

```bash
sudo apt update
```

```bash
sudo apt check
```

```bash
sudo apt --fix-broken install
```

### Services

```bash
systemctl --failed
```

```bash
systemctl status SERVICE_NAME
```

```bash
journalctl -u SERVICE_NAME -b
```

### Network

```bash
ip addr
```

```bash
ip route
```

```bash
sudo ss -tulpn
```

### Firewall

```bash
sudo ufw status verbose
```

### Git

```bash
git status
```

```bash
git remote -v
```

```bash
ssh -T git@github.com
```

### WezTerm

```bash
wezterm --version
```

```bash
wezterm check
```

### Neovim

```bash
nvim --version
```

```vim
:checkhealth
```

### VirtualBox

```bash
VBoxManage --version
```

```bash
VBoxManage list vms
```

### Bluetooth

```bash
systemctl status bluetooth
```

### ClamAV

```bash
clamscan --version
```

```bash
systemctl status clamav-freshclam
```

### GNOME Extensions

```bash
gnome-extensions list
```

```bash
gnome-extensions list --enabled
```

---

## Important Principles

When troubleshooting the workstation:

1. Identify the exact component that is failing.
2. Reproduce the problem.
3. Capture the exact error message.
4. Check the configuration.
5. Check the relevant logs.
6. Make one change at a time.
7. Verify the result.
8. Avoid destructive commands unless they are necessary.
9. Avoid blindly copying commands from unrelated troubleshooting guides.
10. Keep a record of significant system changes.

The objective is not simply to make an error disappear, but to understand the underlying cause and apply the smallest appropriate fix.

---

This completes the documentation in the `docs/` directory for the Ubuntu workstation setup.
