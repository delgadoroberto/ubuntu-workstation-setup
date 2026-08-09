# Essential Packages

Install the packages commonly required for a fresh Ubuntu workstation before configuring development tools and other applications.

This guide applies to Ubuntu 26.04.

> Git is intentionally documented in [Git](07-git.md) and is not installed in this chapter.

---

## 1. Update the Package Index

Make sure the local package index is current:

```bash
sudo apt update
```

This step is normally already completed in [System Update](01-system-update.md), but running it before installing packages ensures that APT has current package information.

---

## 2. Install Essential Command-Line Tools

Install a small set of general-purpose utilities:

```bash
sudo apt install -y \
  build-essential \
  ca-certificates \
  curl \
  wget \
  unzip \
  zip
```

### Packages included

| Package | Purpose |
| --- | --- |
| `build-essential` | Compiler and build toolchain, including GCC, G++, and Make |
| `ca-certificates` | Trusted CA certificates used by TLS-enabled applications |
| `curl` | Command-line tool for transferring data over network protocols |
| `wget` | Command-line utility for downloading files |
| `unzip` | Extract ZIP archives |
| `zip` | Create ZIP archives |

`build-essential` is particularly useful for compiling software and building native dependencies.

---

## 3. Install Multimedia Support

Install Ubuntu's restricted extras metapackage:

```bash
sudo apt install -y ubuntu-restricted-extras
```

This package provides commonly used multimedia codecs and fonts that are not included in the default Ubuntu installation.

During installation, some packages may require interaction with the package installer. Read the prompts carefully before continuing.

---

## 4. Install GNOME Tweaks

Install GNOME Tweaks:

```bash
sudo apt install -y gnome-tweaks
```

Launch it with:

```bash
gnome-tweaks
```

GNOME Tweaks provides additional configuration options for the GNOME desktop environment, including appearance, fonts, keyboard and mouse behavior, startup applications, and window settings.

Detailed GNOME Extension configuration is covered separately in [GNOME Extensions](11-gnome-extensions.md).

---

## 5. Install Archive Utilities

Install support for common archive formats:

```bash
sudo apt install -y rar unrar 7zip 7zip-rar
```

### Archive packages included

| Package | Purpose |
| --- | --- |
| `rar` | Create and manage RAR archives |
| `unrar` | Extract RAR archives |
| `7zip` | Create and extract 7z and other supported archive formats |
| `7zip-rar` | RAR plugin for 7-Zip |

### Ubuntu 26.04 note

Ubuntu 26.04 provides `7zip` and `7zip-rar` as the current package names.

Older Ubuntu documentation may use:

```bash
p7zip-full
p7zip-rar
```

These are legacy package names. In Ubuntu 26.04, `p7zip-full` is provided through the `7zip` package, while `p7zip-rar` is no longer the package name used for the current RAR plugin.

For this reason, this guide uses:

```bash
7zip
7zip-rar
```

instead of the older `p7zip-*` package names.

---

## 6. Verify the Installation

Check the installed versions and commands:

```bash
gcc --version
```

```bash
curl --version
```

```bash
wget --version
```

```bash
unzip -v
```

```bash
zip -v
```

Check the archive utilities:

```bash
rar
```

```bash
unrar
```

```bash
7z
```

Check GNOME Tweaks:

```bash
gnome-tweaks --version
```

---

## 7. Verify Installed Packages

You can confirm the packages installed by APT:

```bash
apt list --installed 2>/dev/null | grep -E 'build-essential|ca-certificates|curl|wget|unzip|zip|ubuntu-restricted-extras|gnome-tweaks|rar|unrar|7zip|7zip-rar'
```

---

## Package Summary

The packages installed by this chapter are:

```text
build-essential
ca-certificates
curl
wget
unzip
zip
ubuntu-restricted-extras
gnome-tweaks
rar
unrar
7zip
7zip-rar
```

Git is intentionally excluded because it has its own dedicated chapter.

Once these packages are installed and verified, continue with [System Optimization](03-system-optimization.md).
