# Ubuntu Workstation Setup

A practical guide for setting up and configuring a fresh Ubuntu 26.04 workstation for daily use, development, virtualization, and cybersecurity work.

The repository documents the installation, configuration, optimization, security, and maintenance steps required to transform a fresh Ubuntu installation into a practical workstation environment.

---

## Overview

Setting up a new Linux workstation usually involves repeating the same tasks:

- Updating the operating system.
- Installing essential packages.
- Configuring system parameters.
- Configuring memory and swap.
- Disabling unnecessary services.
- Installing security tools.
- Installing development and productivity applications.
- Configuring Git.
- Configuring WezTerm and Neovim.
- Installing and configuring VirtualBox.
- Configuring GNOME extensions.
- Cleaning unnecessary packages and files.
- Troubleshooting common issues.

This repository organizes these tasks into a structured, repeatable installation process.

---

## Target Environment

This repository is designed for:

- **Operating System:** Ubuntu 26.04
- **Desktop Environment:** GNOME
- **Architecture:** x86_64
- **Primary use:** Workstation, development, cybersecurity, virtualization, and general productivity

The instructions may also work on other Ubuntu releases, but they are specifically maintained and tested with Ubuntu 26.04.

---

## What This Repository Covers

### System Configuration

- System updates and upgrades
- Essential packages
- System optimization
- Swap configuration
- Bluetooth configuration
- System cleanup

### Security

- UFW
- GUFW
- ClamAV
- Basic security considerations

### Development and Productivity

- Git
- WezTerm
- Neovim
- Lua-based configuration

### Virtualization

- VirtualBox
- `vboxusers` configuration
- Hardware virtualization verification
- Virtual machine configuration

### Desktop Environment

- GNOME Extensions
- Recommended extensions
- Extension management

### Troubleshooting

- APT and package problems
- Network issues
- Git and SSH problems
- WezTerm problems
- Neovim configuration problems
- VirtualBox problems
- Bluetooth issues
- UFW and GUFW issues
- ClamAV issues
- GNOME extension problems
- System service and journal troubleshooting

---

## Requirements

Before starting, make sure you have:

- A fresh or existing Ubuntu 26.04 installation.
- A user account with `sudo` privileges.
- An active Internet connection.
- Sufficient disk space for the applications and virtual machines you intend to use.
- Hardware virtualization support if VirtualBox will be used.

Verify that the current user has administrative privileges:

```bash
sudo -v
```

Verify the Ubuntu version:

```bash
lsb_release -a
```

---

## Installation Guide

The documentation is organized in the recommended order for configuring the workstation.

### 1. System Update

Update the operating system and package repositories.

[Read the System Update guide](docs/01-system-update.md)

---

### 2. Essential Packages

Install common packages and utilities required for the workstation.

[Read the Essential Packages guide](docs/02-essential-packages.md)

---

### 3. System Optimization

Configure workstation-level system parameters, including memory and swap behavior.

[Read the System Optimization guide](docs/03-system-optimization.md)

---

### 4. Bluetooth

Configure Bluetooth according to the workstation's requirements, including disabling the Bluetooth service when it is not needed.

[Read the Bluetooth guide](docs/04-bluetooth.md)

---

### 5. Security

Install and configure the basic security components used by the workstation:

- UFW
- GUFW
- ClamAV

[Read the Security guide](docs/05-security.md)

---

### 6. Cleanup

Remove unnecessary packages and clean package-manager caches after the main installation and configuration steps.

[Read the Cleanup guide](docs/06-cleanup.md)

---

### 7. Git

Install and configure Git for source control and development workflows.

[Read the Git guide](docs/07-git.md)

---

### 8. WezTerm

Install WezTerm and configure it using a Lua configuration file.

[Read the WezTerm guide](docs/08-wezterm.md)

---

### 9. Neovim

Install Neovim and configure it using Lua.

[Read the Neovim guide](docs/09-neovim.md)

---

### 10. VirtualBox

Install VirtualBox, configure the `vboxusers` group, verify hardware virtualization, and configure the default virtual machine location.

[Read the VirtualBox guide](docs/10-virtualbox.md)

---

### 11. GNOME Extensions

Install and manage the recommended GNOME Shell extensions for the workstation.

[Read the GNOME Extensions guide](docs/11-gnome-extensions.md)

---

### 12. Troubleshooting

Use the troubleshooting guide when an installation or configuration step does not work as expected.

[Read the Troubleshooting guide](docs/12-troubleshooting.md)

---

## Configuration Files

The repository can store user-level configuration files that can be copied to their corresponding locations.

### WezTerm

Repository configuration:

```text
configs/wezterm/wezterm.lua
```

Active configuration:

```text
~/.config/wezterm/wezterm.lua
```

Install the repository configuration with:

```bash
mkdir -p "$HOME/.config/wezterm"
cp configs/wezterm/wezterm.lua "$HOME/.config/wezterm/wezterm.lua"
```

---

### Neovim

Repository configuration:

```text
configs/nvim/init.lua
```

Active configuration:

```text
~/.config/nvim/init.lua
```

Install the repository configuration with:

```bash
mkdir -p "$HOME/.config/nvim"
cp configs/nvim/init.lua "$HOME/.config/nvim/init.lua"
```

---

## Recommended Installation Order

For a fresh Ubuntu 26.04 workstation, follow the documentation in order:

```text
01 System Update
       ↓
02 Essential Packages
       ↓
03 System Optimization
       ↓
04 Bluetooth
       ↓
05 Security
       ↓
06 Cleanup
       ↓
07 Git
       ↓
08 WezTerm
       ↓
09 Neovim
       ↓
10 VirtualBox
       ↓
11 GNOME Extensions
       ↓
12 Troubleshooting
```

The troubleshooting guide is primarily a reference and does not need to be followed sequentially.

---

## Repository Structure

```text
ubuntu-workstation-setup/
├── README.md
├── LICENSE
├── CODE_OF_CONDUCT.md
├── CONTRIBUTING.md
├── SECURITY.md
├── .gitignore
│
├── configs/
│   ├── nvim/
│   │   └── init.lua
│   └── wezterm/
│       └── wezterm.lua
│
├── docs/
│   ├── 01-system-update.md
│   ├── 02-essential-packages.md
│   ├── 03-system-optimization.md
│   ├── 04-bluetooth.md
│   ├── 05-security.md
│   ├── 06-cleanup.md
│   ├── 07-git.md
│   ├── 08-wezterm.md
│   ├── 09-neovim.md
│   ├── 10-virtualbox.md
│   ├── 11-gnome-extensions.md
│   └── 12-troubleshooting.md
│
└── .github/
    ├── workflows/
    └── ...
```

---

## Design Principles

This repository follows a few principles to keep the setup maintainable.

### Keep the configuration explicit

Commands and configuration changes should be documented rather than hidden behind opaque scripts.

### Prefer official sources

Applications and packages should preferably be installed from:

- Ubuntu repositories
- Official project repositories
- Official project release pages

Avoid installing software from untrusted third-party sources.

### Minimize unnecessary modifications

Only make system changes that provide a clear benefit to the workstation.

### Verify changes

After important configuration changes, verify the resulting system state.

Examples:

```bash
systemctl --failed
```

```bash
sudo ufw status verbose
```

```bash
free -h
```

```bash
df -h
```

### Keep security in mind

A workstation should not expose unnecessary network services or install unnecessary software.

Review firewall rules, installed applications, GNOME extensions, and system services periodically.

---

## Security Considerations

This repository contains commands that modify system configuration and install software.

Review each command before executing it.

In particular, pay attention to commands involving:

- `sudo`
- Firewall rules
- User and group membership
- System services
- Kernel modules
- Virtualization
- Third-party repositories
- GNOME extensions
- Filesystem permissions

Never execute commands from this repository blindly on production systems.

Always understand what a command changes before running it.

---

## Backup Recommendation

Before applying significant configuration changes to an existing workstation, create a backup of important data and configuration files.

Examples include:

```text
~/.config/
~/.ssh/
~/.gitconfig
```

Do not overwrite existing configuration files without reviewing them first.

---

## Maintenance

This repository is intended to evolve as Ubuntu, GNOME, and the documented applications change.

Periodically review:

- Ubuntu releases
- Package availability
- WezTerm configuration compatibility
- Neovim configuration compatibility
- VirtualBox compatibility
- GNOME extension compatibility
- Security recommendations
- Third-party repository availability

Do not assume that a command documented for one Ubuntu release will remain unchanged indefinitely.

---

## Contributing

Contributions, corrections, improvements, and suggestions are welcome.

Before submitting changes, please review:

[CONTRIBUTING.md](CONTRIBUTING.md)

For security-related issues, please review:

[SECURITY.md](SECURITY.md)

---

## Disclaimer

This repository is provided for educational and practical workstation configuration purposes.

System configuration can vary depending on hardware, Ubuntu version, desktop environment, installed software, and user requirements.

Commands that modify the operating system should be reviewed before execution.

The author is not responsible for data loss, system instability, hardware issues, or other consequences resulting from the use of this repository.

---

## 📄 License

This project is licensed under the MIT License. See the `LICENSE` file for details.
