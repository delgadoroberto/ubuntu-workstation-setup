# VirtualBox

[VirtualBox](https://www.virtualbox.org/) is a virtualization platform that allows you to run virtual machines on an Ubuntu workstation.

This guide covers the installation and basic configuration of VirtualBox on Ubuntu 26.04, including adding the current user to the `vboxusers` group.

---

## 1. Install VirtualBox

Install VirtualBox from the Ubuntu package repositories:

```bash
sudo apt update
```

Then:

```bash
sudo apt install -y virtualbox
```

APT will install VirtualBox and the required dependencies.

> The exact VirtualBox version depends on the package available for Ubuntu 26.04. This guide intentionally does not hard-code a specific version.

---

## 2. Verify the Installation

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
apt policy virtualbox
```

---

## 3. Check the Current User

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

## 4. Add the User to the `vboxusers` Group

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

---

## 5. Apply the Group Membership

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

## 6. Verify the `vboxusers` Group

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

## 7. Launch VirtualBox

Launch the graphical VirtualBox application:

```bash
VirtualBox
```

You can also start it from the Ubuntu application menu.

The VirtualBox Manager should open without requiring `sudo`.

---

## 8. Verify VirtualBox with VBoxManage

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

## 9. Check Virtualization Support

VirtualBox requires hardware virtualization support.

On Intel systems, check whether the CPU exposes VT-x:

```bash
grep -E --color 'vmx|svm' /proc/cpuinfo
```

For Intel CPUs, `vmx` indicates Intel VT-x support.

For AMD CPUs, `svm` indicates AMD-V support.

A simpler check is:

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

---

## 10. Check the VirtualBox Kernel Modules

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

---

## 11. Check the VirtualBox Kernel Driver

Check the `vboxdrv` module:

```bash
lsmod | grep vboxdrv
```

If the module is loaded, output similar to the following should appear:

```text
vboxdrv
```

If no output is returned, do not immediately assume that VirtualBox is broken. The module may not currently be loaded because no VirtualBox functionality requiring it has been started.

---

## 12. Configure the Default Virtual Machine Location

VirtualBox stores virtual machine files on the host filesystem.

You can view the current default machine folder:

```bash
VBoxManage list systemproperties | grep -i "Default machine folder"
```

If desired, configure a dedicated directory.

For example:

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

## 13. Check Available Disk Space

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

## 14. Optional: Create a Dedicated ISO Directory

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

## 15. VirtualBox Extension Pack

VirtualBox also provides an Extension Pack with additional functionality.

The Extension Pack version must match the installed VirtualBox version.

Check the installed version:

```bash
VBoxManage --version
```

If you decide to install an Extension Pack, download the matching version from the official VirtualBox website.

Do not install an Extension Pack from an unrelated source.

After downloading the matching `.vbox-extpack` file, install it with:

```bash
sudo VBoxManage extpack install /path/to/Oracle_VirtualBox_Extension_Pack.vbox-extpack
```

List installed Extension Packs:

```bash
VBoxManage list extpacks
```

> Extension Pack licensing and redistribution terms are different from the base VirtualBox package. Review the current Oracle licensing information before installing or redistributing it.

---

## 16. Troubleshooting

### `VBoxManage: command not found`

Check the package:

```bash
apt policy virtualbox
```

If VirtualBox is not installed:

```bash
sudo apt install -y virtualbox
```

Then verify:

```bash
VBoxManage --version
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
apt policy virtualbox
```

Check the kernel:

```bash
uname -r
```

Check loaded VirtualBox modules:

```bash
lsmod | grep -E '^vbox'
```

If VirtualBox was recently installed or the kernel was recently updated, reboot the system and test again.

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

The exact name depends on the system firmware.

> Changing firmware settings should be done carefully. Do not change unrelated firmware options.

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

Also check available disk space:

```bash
df -h
```

---

## 17. Verify the Complete Installation

Run:

```bash
VBoxManage --version
```

Then:

```bash
which VirtualBox
```

Verify the user group:

```bash
id -nG | grep -qw vboxusers && echo "vboxusers membership confirmed"
```

Check virtualization support:

```bash
lscpu | grep -i virtualization
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
VirtualBox
├── Installed
├── Version verified
├── Hardware virtualization checked
├── User added to vboxusers
├── Group membership verified
├── Kernel modules checked
├── Default VM location reviewed
└── VBoxManage tested
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
