# System Cleanup

This guide covers basic cleanup tasks that can be performed after updating Ubuntu and installing the required packages.

The objective is to remove unnecessary packages and cached package files without deleting files that are required by the system.

This guide applies to Ubuntu 26.04.

> Review the packages proposed for removal before confirming any `autoremove` operation.

---

## 1. Check for Unused Packages

APT can identify packages that were automatically installed as dependencies and are no longer required.

Run:

```bash
sudo apt autoremove
```

APT will display the packages that are going to be removed.

Review the list carefully before confirming.

If you do not want to remove the listed packages, cancel the operation.

---

## 2. Remove Unused Packages

If the packages listed by `apt autoremove` are no longer required, confirm the operation.

You can also explicitly run:

```bash
sudo apt autoremove -y
```

Using `-y` automatically confirms the operation.

For an interactive workstation setup, reviewing the packages before confirming is generally preferable.

---

## 3. Clean Downloaded Package Files

APT stores downloaded package files in its local cache.

To remove package files that can no longer be downloaded from the configured repositories, run:

```bash
sudo apt autoclean
```

`autoclean` removes obsolete package files from the local cache while retaining package files that are still available from the configured repositories.

---

## 4. Clean the APT Package Cache

To remove all cached package files:

```bash
sudo apt clean
```

Unlike `apt autoclean`, the `clean` operation removes all downloaded package files from the local APT cache.

The packages themselves remain installed.

> APT will download packages again when they are required in the future.

---

## 5. Check the APT Cache

You can inspect the size of the APT package cache before or after cleaning:

```bash
sudo du -sh /var/cache/apt/archives/
```

After running:

```bash
sudo apt clean
```

the cache should contain little or no cached `.deb` package data.

---

## 6. Remove Unused Configuration Files

When packages are removed, their configuration files may sometimes remain on the system.

You can list packages in the `rc` state:

```bash
dpkg --list | awk '/^rc/ { print $2 }'
```

The `rc` state means:

```text
r = package removed
c = configuration files remain
```

If the command returns no output, there are no packages in this state.

---

## 7. Purge Residual Configuration Files

If residual configuration files are present, review them first:

```bash
dpkg --list | awk '/^rc/ { print $2 }'
```

You can purge specific packages with:

```bash
sudo apt purge package-name
```

For example:

```bash
sudo apt purge package-name
```

Replace `package-name` with the package you have reviewed and confirmed is no longer required.

> Avoid blindly purging every package in the `rc` state. Review the list before removing residual configuration files.

---

## 8. Check for Broken Dependencies

Verify that the package manager does not report broken dependencies:

```bash
sudo apt check
```

If the system is healthy, APT should not report dependency problems.

If dependency problems are reported, investigate and resolve them before continuing with the workstation setup.

---

## 9. Check Disk Usage

Check the available disk space:

```bash
df -h
```

Pay particular attention to the root filesystem:

```text
/
```

You can also identify large directories with:

```bash
sudo du -xh --max-depth=1 / 2>/dev/null | sort -h
```

This command can help identify directories consuming significant amounts of disk space.

---

## 10. Check the Home Directory

Inspect the size of directories in the user's home directory:

```bash
du -xh --max-depth=1 "$HOME" 2>/dev/null | sort -h
```

This can help identify large personal directories such as:

- Downloads
- Documents
- Videos
- Virtual machines
- Development projects
- Local application data

Do not delete files simply because they are large. Review their purpose before removing anything.

---

## 11. Optional: Clean the Downloads Directory

The Downloads directory often contains installation files and archives that are no longer required.

List its contents:

```bash
ls -lah "$HOME/Downloads"
```

Review the files before deleting anything.

If you are certain that the files are no longer required, remove individual files explicitly:

```bash
rm "$HOME/Downloads/file-name"
```

Avoid using broad commands such as:

```bash
rm -rf "$HOME/Downloads/"*
```

unless you intentionally want to delete everything in the directory.

---

## 12. Clean Temporary Files

Ubuntu automatically manages many temporary files.

Before manually deleting anything from `/tmp`, inspect the directory:

```bash
ls -lah /tmp
```

Do not manually delete system files or directories unless you understand their purpose.

For normal workstation maintenance, manual deletion of `/tmp` is generally unnecessary.

---

## 13. Review System Logs

Systemd journal logs can consume disk space over time.

Check the current journal size:

```bash
journalctl --disk-usage
```

If the journal has grown significantly, old logs can be removed according to an appropriate retention policy.

For example, retain only the last seven days:

```bash
sudo journalctl --vacuum-time=7d
```

Alternatively, limit the journal to a specific size:

```bash
sudo journalctl --vacuum-size=500M
```

> Do not routinely delete all system logs. Logs are valuable for troubleshooting, security investigations, and system administration.

---

## 14. Final Cleanup Sequence

After completing the workstation setup, the following sequence can be used for basic APT cleanup:

```bash
sudo apt autoremove
```

Review the proposed changes.

Then:

```bash
sudo apt autoclean
```

Finally:

```bash
sudo apt clean
```

Check for dependency problems:

```bash
sudo apt check
```

And verify available disk space:

```bash
df -h
```

---

## 15. Cleanup Verification

Run the following commands to verify the final state:

### Check for unused packages

```bash
sudo apt autoremove
```

If no packages are listed for removal, the system does not currently have packages identified by APT as automatically installed dependencies that are no longer required.

Cancel the operation if there is nothing to remove.

### Check package dependencies

```bash
sudo apt check
```

### Check APT cache

```bash
sudo du -sh /var/cache/apt/archives/
```

### Check disk usage

```bash
df -h
```

### Check journal size

```bash
journalctl --disk-usage
```

---

## Cleanup Summary

The recommended basic cleanup sequence is:

```text
Review unused packages
        ↓
apt autoremove
        ↓
apt autoclean
        ↓
apt clean
        ↓
apt check
        ↓
Review disk usage
        ↓
Continue with workstation setup
```

The main commands are:

```bash
sudo apt autoremove
sudo apt autoclean
sudo apt clean
sudo apt check
```

---

## Important Considerations

System cleanup should be conservative.

Avoid deleting files or directories simply because they appear unnecessary.

In particular:

- Do not manually delete files from `/usr`.
- Do not manually delete files from `/var/lib`.
- Do not remove packages without reviewing their dependencies.
- Do not delete system logs indiscriminately.
- Do not remove files from `/tmp` unless you understand their purpose.
- Do not use broad `rm -rf` commands for routine cleanup.
- Do not remove configuration files without confirming that the related software is no longer required.

The goal of this chapter is to remove unnecessary package data and safely reclaim disk space, not to aggressively remove system files.

Once cleanup is complete, continue with [Git](07-git.md).
