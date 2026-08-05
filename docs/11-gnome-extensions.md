# GNOME Extensions

GNOME Extensions allow users to add functionality and customize the GNOME desktop environment.

This guide documents the recommended GNOME extensions for this Ubuntu workstation setup.

This guide applies to Ubuntu 26.04.

> GNOME Extensions can change between GNOME releases. Always verify that an extension supports the GNOME version installed on the workstation before installing it.

---

## 1. Check the GNOME Version

Before installing extensions, check the installed GNOME version:

```bash
gnome-shell --version
```

Example:

```text
GNOME Shell 49.x
```

The exact version depends on the Ubuntu 26.04 desktop environment.

You can also check the desktop environment:

```bash
echo "$XDG_CURRENT_DESKTOP"
```

And:

```bash
echo "$XDG_SESSION_DESKTOP"
```

---

## 2. Install the GNOME Extensions Application

Ubuntu provides an application for managing GNOME Shell extensions.

Install it with:

```bash
sudo apt install -y gnome-shell-extension-manager
```

Verify the package:

```bash
apt policy gnome-shell-extension-manager
```

Launch it with:

```bash
extension-manager
```

You can also launch **Extension Manager** from the Ubuntu application menu.

---

## 3. Recommended Extensions

The following extensions are recommended for this workstation setup.

The list is intentionally small to avoid unnecessary modifications to the GNOME desktop.

### 3.1 AppIndicator and KStatusNotifierItem Support

Provides support for applications that use legacy system tray indicators.

This can be useful for applications such as:

- VirtualBox
- VPN clients
- Backup applications
- Other applications that expose tray indicators

Before installing, search for:

```text
AppIndicator and KStatusNotifierItem Support
```

in Extension Manager.

---

### 3.2 Clipboard Indicator

Provides a clipboard history indicator in the GNOME panel.

Search for:

```text
Clipboard Indicator
```

This extension can be useful when working with:

- Terminal commands
- Configuration files
- Documentation
- Development workflows
- Security tools

> Clipboard managers may retain sensitive information. Avoid copying passwords, API keys, private keys, or other secrets into the clipboard when possible.

---

### 3.3 Dash to Panel

Combines the application dash and top panel into a single panel.

Search for:

```text
Dash to Panel
```

This extension provides a more traditional desktop layout.

It is optional and should only be installed if this workflow is preferred.

---

### 3.4 User Themes

Allows GNOME Shell themes to be customized.

Search for:

```text
User Themes
```

This extension is optional.

It is useful if the workstation uses a custom GNOME Shell theme.

---

## 4. Install Extensions with Extension Manager

Open Extension Manager:

```bash
extension-manager
```

Use the **Browse** section to search for the desired extension.

For each extension:

1. Search for the extension name.
2. Review the extension description.
3. Check the supported GNOME Shell versions.
4. Review the extension's current maintenance status.
5. Install the extension.
6. Enable it if required.
7. Verify that GNOME continues to operate normally.

Do not install an extension simply because it appears in a generic customization list.

---

## 5. Check Installed Extensions

List the installed GNOME extensions:

```bash
gnome-extensions list
```

This returns extension UUIDs.

To see enabled extensions:

```bash
gnome-extensions list --enabled
```

To see disabled extensions:

```bash
gnome-extensions list --disabled
```

---

## 6. Inspect an Extension

To inspect a specific extension:

```bash
gnome-extensions info EXTENSION_UUID
```

Replace:

```text
EXTENSION_UUID
```

with the UUID returned by:

```bash
gnome-extensions list
```

For example:

```bash
gnome-extensions info example@example.com
```

---

## 7. Enable an Extension

An installed extension can be enabled with:

```bash
gnome-extensions enable EXTENSION_UUID
```

Replace `EXTENSION_UUID` with the actual UUID.

Verify:

```bash
gnome-extensions list --enabled
```

---

## 8. Disable an Extension

If an extension causes problems or is no longer required:

```bash
gnome-extensions disable EXTENSION_UUID
```

Verify:

```bash
gnome-extensions list --disabled
```

---

## 9. Remove an Extension

If an extension is no longer required, remove it with:

```bash
gnome-extensions uninstall EXTENSION_UUID
```

Replace `EXTENSION_UUID` with the actual extension UUID.

Verify:

```bash
gnome-extensions list
```

---

## 10. Extension Configuration

Some extensions provide configuration options.

List available extensions:

```bash
gnome-extensions list
```

Then open the extension's preferences:

```bash
gnome-extensions prefs EXTENSION_UUID
```

Replace:

```text
EXTENSION_UUID
```

with the appropriate UUID.

If the extension does not provide preferences, the command may report that no preferences are available.

---

## 11. Review Extension Status

You can check the state of all installed extensions with:

```bash
gnome-extensions list
```

For each extension, determine whether it is:

```text
Enabled
```

or:

```text
Disabled
```

An extension that is installed but disabled does not normally modify the active GNOME Shell session.

---

## 12. Troubleshooting

### Extension does not appear in Extension Manager

Check the GNOME Shell version:

```bash
gnome-shell --version
```

Then verify that the extension supports the installed GNOME version.

Do not force an incompatible extension to run.

---

### Extension causes GNOME Shell problems

Disable the extension:

```bash
gnome-extensions disable EXTENSION_UUID
```

Then restart the affected session if necessary.

If the extension continues to cause problems, uninstall it:

```bash
gnome-extensions uninstall EXTENSION_UUID
```

---

### Extension does not enable

Check the extension information:

```bash
gnome-extensions info EXTENSION_UUID
```

Check the GNOME version:

```bash
gnome-shell --version
```

Then review whether the extension supports the installed GNOME Shell version.

---

### GNOME Extensions command is unavailable

Check whether the command exists:

```bash
which gnome-extensions
```

If it is unavailable, verify the GNOME Shell installation:

```bash
apt policy gnome-shell
```

The `gnome-extensions` command is normally provided as part of the GNOME Shell environment.

---

## 13. Keep the Number of Extensions Reasonable

GNOME extensions modify the desktop environment and can affect:

- Stability
- Performance
- Login behavior
- GNOME Shell updates
- Memory usage
- Desktop compatibility

For this reason, install only extensions that provide functionality you actually need.

A workstation does not need dozens of extensions to be useful.

A minimal setup is easier to maintain and troubleshoot.

---

## 14. Recommended Extension List

The recommended baseline for this repository is:

```text
GNOME Extensions
├── AppIndicator and KStatusNotifierItem Support
├── Clipboard Indicator
├── Dash to Panel              (Optional)
└── User Themes                (Optional)
```

The first two extensions are the primary recommendations.

The last two are optional desktop customization components.

---

## 15. Verify the Installation

Check the GNOME version:

```bash
gnome-shell --version
```

Check the installed extensions:

```bash
gnome-extensions list
```

Check enabled extensions:

```bash
gnome-extensions list --enabled
```

Launch Extension Manager:

```bash
extension-manager
```

If Extension Manager opens successfully and the required extensions are enabled, the GNOME extension setup is complete.

---

## Configuration Summary

The GNOME extension setup consists of:

```text
GNOME Extensions
├── GNOME version checked
├── Extension Manager installed
├── Recommended extensions reviewed
├── Required extensions installed
├── Extensions enabled
└── Extension status verified
```

The main management commands are:

```bash
gnome-extensions list
```

```bash
gnome-extensions list --enabled
```

```bash
gnome-extensions enable EXTENSION_UUID
```

```bash
gnome-extensions disable EXTENSION_UUID
```

```bash
gnome-extensions uninstall EXTENSION_UUID
```

---

## Security Considerations

GNOME Shell extensions run with significant access to the desktop environment.

Treat extensions as software and install them carefully.

Before installing an extension:

1. Verify the extension name.
2. Check the developer or maintainer.
3. Check whether it is actively maintained.
4. Verify compatibility with the installed GNOME Shell version.
5. Review permissions and functionality.
6. Avoid extensions that are unnecessary for the workstation.

Do not install extensions from random websites or execute installation scripts from untrusted sources.

Prefer established sources such as the GNOME Extensions ecosystem and Extension Manager.

---

Once the GNOME extensions have been configured, continue with [Troubleshooting](12-troubleshooting.md).
