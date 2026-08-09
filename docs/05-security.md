# Security

This guide covers basic security components for an Ubuntu workstation.

The configuration includes:

- UFW (Uncomplicated Firewall)
- GUFW (Graphical Uncomplicated Firewall)
- ClamAV
- Basic firewall verification
- Basic antivirus verification

This guide applies to Ubuntu 26.04.

> This chapter provides baseline workstation security. It is not intended to replace a comprehensive Linux hardening guide.

---

## 1. Install UFW

Install UFW:

```bash
sudo apt install -y ufw
```

Verify the installation:

```bash
ufw --version
```

---

## 2. Check the Current Firewall Status

Before enabling the firewall, check its current status:

```bash
sudo ufw status verbose
```

A fresh Ubuntu installation may report:

```text
Status: inactive
```

---

## 3. Configure Default Firewall Policies

Set the default incoming policy to deny:

```bash
sudo ufw default deny incoming
```

Allow outgoing connections:

```bash
sudo ufw default allow outgoing
```

This creates a basic workstation firewall policy:

```text
Incoming connections: DENY
Outgoing connections: ALLOW
```

This is a common baseline for desktop systems where services are not intentionally exposed to the network.

---

## 4. Allow SSH Before Enabling UFW

If SSH access is used on the workstation, allow SSH before enabling the firewall:

```bash
sudo ufw allow OpenSSH
```

Alternatively, specify the SSH port explicitly:

```bash
sudo ufw allow 22/tcp
```

Verify the rule:

```bash
sudo ufw status numbered
```

> If SSH is not used, do not add an SSH firewall rule unnecessarily.

> If you are connected to the workstation remotely through SSH, make sure the appropriate SSH rule is configured before enabling UFW. Otherwise, the firewall may block your current connection.

---

## 5. Enable UFW

Enable the firewall:

```bash
sudo ufw enable
```

When prompted, confirm the operation.

Verify the status:

```bash
sudo ufw status verbose
```

Expected output should indicate that the firewall is active.

---

## 6. Verify UFW Rules

Display the configured rules:

```bash
sudo ufw status numbered
```

For a basic workstation without SSH access, the configuration may contain only the default policies.

If SSH is required, an additional rule should be present for OpenSSH or TCP port 22.

---

## 7. Install GUFW

GUFW provides a graphical interface for managing UFW.

Install it with:

```bash
sudo apt install -y gufw
```

Verify the installation:

```bash
apt policy gufw
```

Launch GUFW from the application menu or from the terminal:

```bash
gufw
```

You may be prompted for administrator authentication.

---

## 8. Configure the Firewall with GUFW

GUFW provides a graphical interface for the same UFW firewall.

The basic configuration should be:

```text
Status: Enabled

Incoming:
Deny

Outgoing:
Allow
```

Avoid creating rules for services that are not required.

For example, do not allow:

```text
HTTP
HTTPS
FTP
SSH
RDP
```

unless the workstation actually requires those services to accept incoming connections.

---

## 9. Verify UFW After Using GUFW

GUFW modifies the underlying UFW configuration, so the command-line interface can be used to verify the resulting rules:

```bash
sudo ufw status verbose
```

And:

```bash
sudo ufw status numbered
```

The configuration shown by UFW should correspond to the settings configured through GUFW.

---

## 10. Install ClamAV

Install ClamAV:

```bash
sudo apt install -y clamav
```

Verify the installation:

```bash
clamscan --version
```

ClamAV provides the `clamscan` command for manually scanning files and directories.

---

## 11. Update ClamAV Virus Definitions

ClamAV uses virus definition databases to identify known malware.

The database can be updated with:

```bash
sudo freshclam
```

Check the installed ClamAV database files:

```bash
ls -lh /var/lib/clamav/
```

> `freshclam` may report that another ClamAV process is already updating the database. If that happens, check the status of the ClamAV update service instead of running multiple update processes simultaneously.
---

## 12. Scan a Directory

To scan a directory recursively:

```bash
clamscan -r /path/to/directory
```

For example, to scan the user's home directory:

```bash
clamscan -r "$HOME"
```

A recursive scan can take a significant amount of time depending on the number and size of files.

---

## 13. Scan for Infected Files

To scan recursively and display only infected files:

```bash
clamscan -r --infected /path/to/directory
```

For example:

```bash
clamscan -r --infected "$HOME"
```

If no infected files are found, ClamAV should report:

```text
Infected files: 0
```

---

## 14. Save Scan Results to a Log

A scan can be redirected to a log file:

```bash
clamscan -r "$HOME" --log="$HOME/clamav-scan.log"
```

Review the log:

```bash
less "$HOME/clamav-scan.log"
```

Remove the log when it is no longer required:

```bash
rm "$HOME/clamav-scan.log"
```

---

## 15. Check ClamAV Services

List the ClamAV-related services:

```bash
systemctl list-units --type=service | grep -i clam
```

You can also check the database update service:

```bash
systemctl status clamav-freshclam
```

If the service is installed and enabled, it can automatically keep the virus definitions updated.

---

## 16. Verify the Security Configuration

Run the following commands to perform a basic verification.

### UFW

```bash
sudo ufw status verbose
```

Expected:

```text
Status: active
```

### Firewall Rules

```bash
sudo ufw status numbered
```

### ClamAV

```bash
clamscan --version
```

### ClamAV Database

```bash
ls -lh /var/lib/clamav/
```

### ClamAV Update Service

```bash
systemctl is-enabled clamav-freshclam
```

---

## Security Configuration Summary

The baseline configuration provided by this chapter is:

```text
UFW
├── Installed
├── Enabled
├── Default incoming policy: DENY
└── Default outgoing policy: ALLOW

GUFW
└── Installed

ClamAV
├── Installed
├── Virus definitions available
└── Manual scanning available
```

The basic UFW configuration can be summarized as:

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable
```

If SSH access is required:

```bash
sudo ufw allow OpenSSH
```

---

## Important Considerations

### UFW Is Not a Complete Security Solution

A firewall helps control network traffic, but it does not protect against every type of threat.

A secure workstation should also use:

- Regular system updates
- Strong authentication
- Least-privilege practices
- Secure application configuration
- Disk encryption when appropriate
- Regular backups
- Secure browser practices
- Appropriate endpoint protection

### ClamAV Is Not a Replacement for Endpoint Security

ClamAV is useful for manual malware scanning and can complement other security controls.

It should not be treated as a complete endpoint detection and response solution.

### Avoid Unnecessary Firewall Rules

Only expose services that are actually required.

Before allowing a port, identify:

1. Which application is listening.
2. Why the service needs to accept connections.
3. Which network interfaces should be accessible.
4. Which source networks should be allowed.
5. Whether the service can be restricted to a specific port or source.

This approach follows the principle of least privilege.

---

Once the security configuration is complete, continue with [Cleanup](06-cleanup.md).
