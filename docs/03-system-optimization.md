# System Optimization

This guide covers a small set of system-level configurations intended to improve the overall behavior of an Ubuntu workstation.

The configuration in this chapter focuses on memory management and avoids unnecessary or obsolete performance tweaks.

This guide applies to Ubuntu 26.04.

---

## 1. Check the Current Memory and Swap Configuration

Before making changes, inspect the current memory and swap usage:

```bash
free -h
```

Check the current swappiness value:

```bash
sysctl vm.swappiness
```

You can also inspect the current value directly:

```bash
cat /proc/sys/vm/swappiness
```

A typical Ubuntu installation may use a higher default swappiness value than the one recommended in this guide.

---

## 2. Configure Swappiness

Swappiness controls how aggressively the Linux kernel uses swap relative to RAM.

For a workstation with sufficient physical memory, a value of `10` can be used to reduce the tendency to move memory pages to swap during normal operation.

### Check the current value

```bash
sysctl vm.swappiness
```

### Temporarily change the value

To test the configuration without making it permanent:

```bash
sudo sysctl vm.swappiness=10
```

Verify the change:

```bash
sysctl vm.swappiness
```

The expected result is:

```text
vm.swappiness = 10
```

This temporary configuration will be lost after a reboot.

---

## 3. Make Swappiness Persistent

To make the configuration persistent across reboots, create a dedicated sysctl configuration file:

```bash
sudo nano /etc/sysctl.d/99-workstation.conf
```

Add:

```text
vm.swappiness=10
```

Save the file and apply the configuration:

```bash
sudo sysctl --system
```

Verify:

```bash
sysctl vm.swappiness
```

Expected result:

```text
vm.swappiness = 10
```

Using a dedicated file under `/etc/sysctl.d/` keeps the workstation-specific configuration separate from the system's default configuration files.

---

## 4. Check the Swap Configuration

Check whether swap is currently enabled:

```bash
swapon --show
```

You can also use:

```bash
free -h
```

Example:

```text
               total        used        free      shared  buff/cache   available
Mem:            ...
Swap:           ...
```

The exact values depend on the workstation's physical RAM and swap configuration.

> Do not disable or recreate swap simply to change the swappiness value. Swappiness controls how the kernel uses available swap; it does not determine the size or type of the swap area.

---

## 5. Verify the Configuration After Reboot

Reboot the system:

```bash
sudo reboot
```

After logging back in, verify the value:

```bash
sysctl vm.swappiness
```

Expected result:

```text
vm.swappiness = 10
```

Also verify memory and swap:

```bash
free -h
```

And:

```bash
swapon --show
```

---

## 6. Avoid Obsolete Performance Tweaks

This repository intentionally does not recommend several older Linux performance tweaks that are frequently found in outdated post-installation guides.

### Preload

`preload` is not included in this setup.

Modern Ubuntu systems already use several mechanisms for application startup and caching, and installing additional background services solely to preload applications is not necessary for this workstation setup.

### Prelink

`prelink` is not included in this setup.

It is an obsolete optimization approach and is not appropriate for a modern Ubuntu workstation.

### Unnecessary Kernel Tweaks

This guide also avoids blindly modifying kernel parameters without a specific performance or operational requirement.

Examples of settings that should not be changed simply because they appear in generic Linux optimization guides include:

- `vm.dirty_ratio`
- `vm.dirty_background_ratio`
- `vm.vfs_cache_pressure`
- TCP/IP kernel parameters
- CPU scheduler parameters
- I/O scheduler parameters

These parameters can have system-wide effects and should only be changed when there is a documented reason and a measurable benefit.

---

## 7. Recommended Verification

After completing the optimization steps, run:

```bash
free -h
```

```bash
swapon --show
```

```bash
sysctl vm.swappiness
```

The expected swappiness value is:

```text
vm.swappiness = 10
```

---

## Configuration Summary

The only persistent optimization applied by this chapter is:

```text
/etc/sysctl.d/99-workstation.conf
```

with:

```text
vm.swappiness=10
```

The configuration can be summarized as:

```text
Check current configuration
        ↓
Test swappiness = 10
        ↓
Create /etc/sysctl.d/99-workstation.conf
        ↓
Apply sysctl configuration
        ↓
Verify
        ↓
Reboot
        ↓
Verify again
```

Once this configuration is complete, continue with [Bluetooth](04-bluetooth.md).
