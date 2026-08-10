# VirtualBox

[VirtualBox](https://www.virtualbox.org/) is a virtualization platform that allows you to run virtual machines on an Ubuntu workstation.

This guide covers the installation and basic configuration of Oracle VirtualBox on Ubuntu 26.04 using the official Oracle APT repository.

The configuration includes:

- Oracle VirtualBox installation
- Oracle package repository configuration
- Kernel headers and DKMS
- `vboxusers` group configuration
- Hardware virtualization verification
- VirtualBox kernel module verification
- Optional default virtual machine location
- Basic troubleshooting
- Optional Extension Pack

> This guide installs VirtualBox from the official Oracle repository rather than the Ubuntu package repository.

---

## 1. Check the Ubuntu Version

Verify that the workstation is running Ubuntu 26.04:

```bash
lsb_release -a
```

You can also check the release information with:

```bash
cat /etc/os-release
```

Ubuntu 26.04 uses the codename:

```text
resolute
```

Verify the codename:

```bash
. /etc/os-release && echo "$VERSION_CODENAME"
```

Expected:

```text
resolute
```

> This guide is intended for Ubuntu 26.04. Do not use the `resolute` repository configuration on a different Ubuntu release.

---

## 2. Check the System Architecture

Oracle provides packages for specific system architectures.

Check the architecture:

```bash
dpkg --print-architecture
```

For a standard 64-bit Intel or AMD Ubuntu workstation, the expected result is:

```text
amd64
```

You can also check the kernel architecture:

```bash
uname -m
```

Expected:

```text
x86_64
```

The architecture of the package must match the architecture supported by the running kernel.

---

## 3. Install Prerequisites

VirtualBox requires kernel modules to integrate with the Linux kernel.

Install the required packages:

```bash
sudo apt update
```

Then:

```bash
sudo apt install -y \
  build-essential \
  dkms \
  linux-headers-$(uname -r) \
  ca-certificates \
  wget \
  gnupg
```

These packages provide:

- `build-essential` for compiling kernel modules.
- `dkms` for rebuilding kernel modules when required.
- `linux-headers-$(uname -r)` for the currently running kernel.
- `ca-certificates` for trusted HTTPS connections.
- `wget` for downloading the Oracle signing key.
- `gnupg` for managing the repository signing key.

Verify the installed kernel:

```bash
uname -r
```

Verify the kernel headers:

```bash
ls -d /usr/src/linux-headers-$(uname -r)
```

If the directory exists, the headers for the running kernel are installed.

Oracle's documentation notes that Debian and Ubuntu systems require appropriate kernel headers for building the VirtualBox kernel modules. :contentReference[oaicite:4]{index=4}

---

## 4. Create the APT Keyring Directory

Create the directory used for repository signing keys:

```bash
sudo install -d -m 0755 /etc/apt/keyrings
```

This keeps the Oracle repository signing key separate from the system's general trusted keyrings.

---

## 5. Download the Oracle VirtualBox Signing Key

Download the official Oracle VirtualBox repository signing key:

```bash
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc \
  -O /tmp/oracle_vbox_2016.asc
```

Convert the ASCII-armored key into a binary keyring:

```bash
sudo gpg --dearmor \
  --output /etc/apt/keyrings/oracle-virtualbox-2016.gpg \
  /tmp/oracle_vbox_2016.asc
```

Remove the temporary key file:

```bash
rm /tmp/oracle_vbox_2016.asc
```

Verify the keyring:

```bash
sudo gpg --show-keys /etc/apt/keyrings/oracle-virtualbox-2016.gpg
```

The Oracle VirtualBox archive signing key currently has the fingerprint:

```text
B9F8 D658 297A F3EF C18D 5CDF A2F6 83C5 2980 AECF
```

Verify the fingerprint before trusting the key.

The key and fingerprint are documented by Oracle. :contentReference[oaicite:5]{index=5}

---

## 6. Add the Oracle VirtualBox Repository

Create an APT source file for the Oracle VirtualBox repository:

```bash
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian resolute contrib" | \
  sudo tee /etc/apt/sources.list.d/virtualbox.list > /dev/null
```

Verify the repository configuration:

```bash
cat /etc/apt/sources.list.d/virtualbox.list
```

Expected:

```text
deb [arch=amd64 signed-by=/etc/apt/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian resolute contrib
```

Oracle currently publishes a `resolute` distribution in its VirtualBox APT repository. :contentReference[oaicite:6]{index=6}

---

## 7. Update the APT Package Index

Update the package index:

```bash
sudo apt update
```

The output should show the Oracle VirtualBox repository:

```text
https://download.virtualbox.org/virtualbox/debian
```

If APT reports a signature or repository error, do not continue with the installation until the repository configuration is corrected.

---

## 8. Check Available VirtualBox Packages

Check the available VirtualBox packages:

```bash
apt policy virtualbox-7.2
```

The candidate package should be provided by the Oracle repository.

You can also search for available VirtualBox packages:

```bash
apt search '^virtualbox'
```

Oracle currently provides VirtualBox 7.2 packages for Ubuntu `resolute`. :contentReference[oaicite:7]{index=7}

> The VirtualBox major version may change over time. If Oracle introduces a newer major package series, update the package name and documentation accordingly.

---

## 9. Install Oracle VirtualBox

Install the current VirtualBox 7.2 package from the Oracle repository:

```bash
sudo apt install -y virtualbox-7.2
```

APT will install the required dependencies.

During installation, VirtualBox attempts to build and configure the required kernel modules for the running kernel.

---

## 10. Verify the Installation

Check the installed VirtualBox version:

```bash
VBoxManage --version
```

You can also verify the executable:

```bash
which VirtualBox
```

And:

```bash
which VBoxManage
```

Check the installed package:

```bash
apt policy virtualbox-7.2
```

Verify the package source:

```bash
apt-cache policy virtualbox-7.2
```

The package should be associated with the Oracle VirtualBox repository.

---

## 11. Check the Current User

Display the current username:

```bash
whoami
```

You can also check the user's groups:

```bash
groups
```

At this point, the `vboxusers` group may not yet be present.

---

## 12. Add the User to the `vboxusers` Group

Add the current user to the VirtualBox users group:

```bash
sudo usermod -aG vboxusers "$USER"
```

This adds the current user to the existing `vboxusers` group without removing the user from any other groups.

Verify that the group exists:

```bash
getent group vboxusers
```

The output should contain the `vboxusers` group.

Oracle's documentation also uses the `vboxusers` group for users who need access to VirtualBox functionality such as USB devices. :contentReference[oaicite:8]{index=8}

---

## 13. Apply the Group Membership

Group membership changes do not normally apply to the current login session immediately.

The simplest approach is to log out and log back in.

Alternatively, reboot the workstation:

```bash
sudo reboot
```

After logging back in, verify the groups:

```bash
groups
```

You should now see:

```text
vboxusers
```

You can also verify directly:

```bash
id
```

The `vboxusers` group should appear in the list of supplementary groups.

> Do not use `sudo VirtualBox` to work around missing group membership. VirtualBox should normally be run as the regular user.

---

## 14. Verify the `vboxusers` Group

Check the group:

```bash
getent group vboxusers
```

You can also check the current user's supplementary groups:

```bash
id -nG
```

To verify specifically:

```bash
id -nG | grep -qw vboxusers && echo "vboxusers membership confirmed"
```

Expected:

```text
vboxusers membership confirmed
```

---

## 15. Check Hardware Virtualization Support

VirtualBox requires hardware virtualization support.

Check whether the CPU exposes virtualization capabilities:

```bash
lscpu | grep -i virtualization
```

Possible output includes:

```text
Virtualization: VT-x
```

or:

```text
Virtualization: AMD-V
```

You can also check the CPU flags:

```bash
grep -E --color 'vmx|svm' /proc/cpuinfo
```

For Intel CPUs:

```text
vmx
```

indicates Intel VT-x.

For AMD CPUs:

```text
svm
```

indicates AMD-V.

If virtualization is not reported, check the system firmware/UEFI settings.

Depending on the system, the option may be named:

```text
Intel Virtualization Technology
Intel VT-x
AMD-V
SVM Mode
```

The exact name depends on the system firmware.

> Changing firmware settings should be done carefully. Do not change unrelated firmware options.

---

## 16. Check the VirtualBox Kernel Modules

VirtualBox uses kernel modules to provide virtualization functionality.

Check whether the VirtualBox modules are loaded:

```bash
lsmod | grep -E '^vbox'
```

Typical modules may include:

```text
vboxdrv
vboxnetflt
vboxnetadp
```

The exact modules loaded depend on the VirtualBox configuration and whether virtual machines or networking features are currently being used.

Check specifically for `vboxdrv`:

```bash
lsmod | grep vboxdrv
```

If the module is loaded, output similar to the following should appear:

```text
vboxdrv
```

---

## 17. Check DKMS Status

Verify the DKMS configuration:

```bash
dkms status
```

You should see a VirtualBox-related entry if the kernel modules were registered successfully.

If VirtualBox was recently installed or the kernel was recently updated, reboot the workstation and check again.

---

## 18. Check Secure Boot

Secure Boot can affect the loading of third-party kernel modules.

Check whether Secure Boot is enabled:

```bash
mokutil --sb-state
```

If `mokutil` is not installed:

```bash
sudo apt install -y mokutil
```

Then:

```bash
mokutil --sb-state
```

Possible output:

```text
SecureBoot enabled
```

or:

```text
SecureBoot disabled
```

When Secure Boot is enabled, VirtualBox kernel modules may need to be signed before they can be loaded.

The relevant modules include:

```text
vboxdrv
vboxnetadp
vboxnetflt
vboxpci
```

If VirtualBox cannot load its kernel modules with Secure Boot enabled, follow the appropriate module-signing procedure for the Ubuntu installation rather than disabling unrelated security controls.

Oracle documents Secure Boot considerations for VirtualBox kernel modules. :contentReference[oaicite:9]{index=9}

---

## 19. Launch VirtualBox

Launch the graphical VirtualBox application:

```bash
VirtualBox
```

You can also start it from the Ubuntu application menu.

The VirtualBox Manager should open without requiring `sudo`.

---

## 20. Verify VirtualBox with VBoxManage

`VBoxManage` is VirtualBox's command-line management interface.

List registered virtual machines:

```bash
VBoxManage list vms
```

If no virtual machines have been created yet, the command may return no entries.

Display host information:

```bash
VBoxManage list hostinfo
```

This provides information about the host system and VirtualBox's ability to access virtualization resources.

---

## 21. Configure the Default Virtual Machine Location

VirtualBox stores virtual machine files on the host filesystem.

View the current default machine folder:

```bash
VBoxManage list systemproperties | grep -i "Default machine folder"
```

If desired, configure a dedicated directory:

```bash
mkdir -p "$HOME/VirtualBox VMs"
```

Then configure it:

```bash
VBoxManage setproperty machinefolder "$HOME/VirtualBox VMs"
```

Verify:

```bash
VBoxManage list systemproperties | grep -i "Default machine folder"
```

> Virtual machines can consume significant amounts of disk space. Make sure the selected filesystem has sufficient free space.

---

## 22. Check Available Disk Space

Before creating virtual machines, check the available disk space:

```bash
df -h
```

You can also check the home directory:

```bash
du -sh "$HOME"
```

If virtual machines will be stored under the home directory, make sure enough free space is available for:

- Virtual disks
- Snapshots
- ISO images
- VM configuration files
- Temporary installation files

---

## 23. Optional: Create a Dedicated ISO Directory

If you regularly install virtual machines, a dedicated ISO directory can make organization easier:

```bash
mkdir -p "$HOME/ISO"
```

Verify:

```bash
ls -ld "$HOME/ISO"
```

Store downloaded operating system installation images there.

---

## 24. VirtualBox Extension Pack

VirtualBox also provides an Extension Pack with additional functionality.

The Extension Pack version must match the installed VirtualBox version exactly.

Check the installed version:

```bash
VBoxManage --version
```

If you decide to install an Extension Pack, download the matching version from the [official VirtualBox download page](https://www.virtualbox.org/wiki/Downloads).

Do not install an Extension Pack from an unrelated source.

After downloading the matching `.vbox-extpack` file, install it with:

```bash
sudo VBoxManage extpack install /path/to/Oracle_VirtualBox_Extension_Pack.vbox-extpack
```

List installed Extension Packs:

```bash
VBoxManage list extpacks
```

> The Extension Pack has licensing and redistribution terms that differ from the base VirtualBox package. Review the current Oracle licensing information before installing or redistributing it.

> The Extension Pack is optional and is not required for the basic VirtualBox configuration described in this guide.

---

## 25. Troubleshooting

### `VBoxManage: command not found`

Check the installed package:

```bash
apt policy virtualbox-7.2
```

If VirtualBox is not installed:

```bash
sudo apt install -y virtualbox-7.2
```

Then verify:

```bash
VBoxManage --version
```

---

### The Oracle repository is not available

Verify the repository:

```bash
cat /etc/apt/sources.list.d/virtualbox.list
```

Expected:

```text
deb [arch=amd64 signed-by=/etc/apt/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian resolute contrib
```

Verify the signing key:

```bash
sudo gpg --show-keys /etc/apt/keyrings/oracle-virtualbox-2016.gpg
```

Then update APT:

```bash
sudo apt update
```

---

### APT reports a repository signature error

Check that the keyring exists:

```bash
ls -l /etc/apt/keyrings/oracle-virtualbox-2016.gpg
```

If necessary, recreate the keyring using the official Oracle signing key:

```bash
wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc \
  -O /tmp/oracle_vbox_2016.asc
```

```bash
sudo gpg --dearmor \
  --output /etc/apt/keyrings/oracle-virtualbox-2016.gpg \
  /tmp/oracle_vbox_2016.asc
```

Remove the temporary file:

```bash
rm /tmp/oracle_vbox_2016.asc
```

Then:

```bash
sudo apt update
```

---

### `vboxusers` does not appear in `groups`

Check the group:

```bash
getent group vboxusers
```

Then check the current session:

```bash
id -nG
```

If the group was added after the current login session started, log out and log back in.

Alternatively, reboot:

```bash
sudo reboot
```

After logging back in:

```bash
id -nG | grep -qw vboxusers && echo "vboxusers membership confirmed"
```

---

### VirtualBox reports that kernel modules are unavailable

Check the installed package:

```bash
apt policy virtualbox-7.2
```

Check the running kernel:

```bash
uname -r
```

Check the kernel headers:

```bash
ls -d /usr/src/linux-headers-$(uname -r)
```

Check DKMS:

```bash
dkms status
```

Check loaded VirtualBox modules:

```bash
lsmod | grep -E '^vbox'
```

If VirtualBox was recently installed or the kernel was recently updated, reboot the system and test again.

If the problem persists, inspect the VirtualBox installation log:

```bash
sudo less /var/log/vbox-install.log
```

Oracle documents `vbox-install.log` as a useful source of information when kernel module compilation fails. :contentReference[oaicite:10]{index=10}

---

### Secure Boot prevents VirtualBox modules from loading

Check Secure Boot:

```bash
mokutil --sb-state
```

If Secure Boot is enabled, verify whether the VirtualBox modules are loaded:

```bash
lsmod | grep -E '^vbox'
```

If the modules cannot be loaded, follow Ubuntu's module-signing procedure for Secure Boot.

Do not disable Secure Boot solely to bypass an installation problem unless there is a specific operational requirement to do so.

---

### Virtualization is disabled

Check:

```bash
lscpu | grep -i virtualization
```

If hardware virtualization is not reported, check the system firmware/UEFI settings.

Depending on the system, the option may be named:

```text
Intel Virtualization Technology
Intel VT-x
AMD-V
SVM Mode
```

---

### VirtualBox cannot start a virtual machine

Check the VirtualBox version:

```bash
VBoxManage --version
```

Check the kernel:

```bash
uname -r
```

Check the VirtualBox kernel modules:

```bash
lsmod | grep -E '^vbox'
```

Check the user's groups:

```bash
id -nG
```

Make sure:

```text
vboxusers
```

is present.

Check Secure Boot:

```bash
mokutil --sb-state
```

Also check available disk space:

```bash
df -h
```

---

## 26. Verify the Complete Installation

Run:

```bash
VBoxManage --version
```

Verify the executable:

```bash
which VirtualBox
```

Verify the package source:

```bash
apt-cache policy virtualbox-7.2
```

Verify the user group:

```bash
id -nG | grep -qw vboxusers && echo "vboxusers membership confirmed"
```

Check virtualization support:

```bash
lscpu | grep -i virtualization
```

Check DKMS:

```bash
dkms status
```

Check VirtualBox modules:

```bash
lsmod | grep -E '^vbox'
```

Check registered virtual machines:

```bash
VBoxManage list vms
```

Check the default VM location:

```bash
VBoxManage list systemproperties | grep -i "Default machine folder"
```

---

## Configuration Summary

The VirtualBox setup consists of:

```text
Oracle VirtualBox
├── Oracle APT repository configured
├── Oracle signing key configured
├── Kernel headers installed
├── DKMS installed
├── VirtualBox installed
├── Version verified
├── Hardware virtualization checked
├── User added to vboxusers
├── Group membership verified
├── Kernel modules checked
├── Secure Boot status checked
├── Default VM location reviewed
└── VBoxManage tested
```

The Oracle repository configuration is:

```text
https://download.virtualbox.org/virtualbox/debian
```

The Ubuntu 26.04 codename is:

```text
resolute
```

The most important user configuration is:

```bash
sudo usermod -aG vboxusers "$USER"
```

After running this command, log out and log back in, or reboot:

```bash
sudo reboot
```

Then verify:

```bash
id -nG
```

The `vboxusers` group should be present.

Once VirtualBox is installed and configured, continue with [GNOME Extensions](11-gnome-extensions.md).
