# System Update

Before installing additional software or applying system configurations, update Ubuntu and make sure all currently installed packages are up to date.

This guide applies to Ubuntu 26.04.

---

## 1. Update the Package Index

Refresh the local package index:

```bash
sudo apt update
```

This retrieves the latest package information from the configured repositories.

> `apt update` does not install or upgrade packages. It only updates the local package index.

---

## 2. Upgrade Installed Packages

Upgrade installed packages to their latest available versions:

```bash
sudo apt upgrade
```

Review the packages that will be upgraded and confirm when prompted.

---

## 3. Perform a Full Upgrade

Run a full upgrade to handle package changes that may require installing or removing dependencies:

```bash
sudo apt full-upgrade
```

Review the proposed changes before confirming.

> `apt full-upgrade` may remove packages when required to resolve dependency changes. Review the transaction carefully before accepting it.

---

## 4. Restart the System

After completing the upgrade, reboot the system:

```bash
sudo reboot
```

A reboot is recommended before continuing with the remaining setup steps, especially when the update includes kernel, system libraries, or other core components.

---

## 5. Verify the Ubuntu Version

After rebooting, verify the installed Ubuntu version:

```bash
lsb_release -a
```

You can also check the kernel version:

```bash
uname -r
```

---

## 6. Verify Pending Updates

Run the package index update again:

```bash
sudo apt update
```

If the system is fully up to date, APT should report that there are no packages requiring an upgrade.

---

## Recommended Order

The recommended sequence for this chapter is:

```text
apt update
      ↓
apt upgrade
      ↓
apt full-upgrade
      ↓
reboot
      ↓
verify Ubuntu version
      ↓
verify pending updates
```

Once these steps are complete, continue with [Essential Packages](02-essential-packages.md).
