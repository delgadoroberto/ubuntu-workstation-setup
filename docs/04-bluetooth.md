# Bluetooth

This guide explains how to disable Bluetooth automatically when Ubuntu starts.

Disabling Bluetooth can be useful on a workstation that does not use Bluetooth peripherals and can also reduce unnecessary background services.

This guide applies to Ubuntu 26.04.

---

## 1. Check the Current Bluetooth Service

Check the current status of the Bluetooth service:

```bash
systemctl status bluetooth
```

You can also check whether the service is enabled to start automatically:

```bash
systemctl is-enabled bluetooth
```

Possible results include:

```text
enabled
```

or:

```text
disabled
```

Check whether the Bluetooth service is currently running:

```bash
systemctl is-active bluetooth
```

Possible results include:

```text
active
```

or:

```text
inactive
```

---

## 2. Disable Bluetooth at Startup

Disable the Bluetooth service so it does not start automatically when Ubuntu boots:

```bash
sudo systemctl disable bluetooth
```

This changes the service configuration so Bluetooth is not automatically started during the normal boot process.

---

## 3. Stop the Current Bluetooth Service

If Bluetooth is currently running, stop the service:

```bash
sudo systemctl stop bluetooth
```

Check the service status:

```bash
systemctl is-active bluetooth
```

The expected result is:

```text
inactive
```

---

## 4. Verify the Service Configuration

Verify that Bluetooth is no longer enabled at startup:

```bash
systemctl is-enabled bluetooth
```

Expected result:

```text
disabled
```

You can also check the complete service status:

```bash
systemctl status bluetooth
```

The service should show that it is inactive and disabled.

---

## 5. Reboot and Verify

Reboot the workstation:

```bash
sudo reboot
```

After logging in, verify the Bluetooth service:

```bash
systemctl is-enabled bluetooth
```

Expected:

```text
disabled
```

Check whether the service is running:

```bash
systemctl is-active bluetooth
```

Expected:

```text
inactive
```

You can also verify the status with:

```bash
systemctl status bluetooth
```

---

## 6. Re-enable Bluetooth

If Bluetooth is needed later, it can be enabled again.

Enable the service at startup:

```bash
sudo systemctl enable bluetooth
```

Start the service immediately:

```bash
sudo systemctl start bluetooth
```

Verify:

```bash
systemctl is-enabled bluetooth
```

Expected:

```text
enabled
```

And:

```bash
systemctl is-active bluetooth
```

Expected:

```text
active
```

---

## 7. Disable Bluetooth Again

To disable Bluetooth again:

```bash
sudo systemctl disable bluetooth
```

Then stop the currently running service:

```bash
sudo systemctl stop bluetooth
```

Verify:

```bash
systemctl is-enabled bluetooth
```

```bash
systemctl is-active bluetooth
```

Expected results:

```text
disabled
inactive
```

---

## Configuration Summary

To disable Bluetooth at startup:

```bash
sudo systemctl disable bluetooth
sudo systemctl stop bluetooth
```

Verify:

```bash
systemctl is-enabled bluetooth
systemctl is-active bluetooth
```

Expected:

```text
disabled
inactive
```

To restore Bluetooth:

```bash
sudo systemctl enable bluetooth
sudo systemctl start bluetooth
```

Verify:

```bash
systemctl is-enabled bluetooth
systemctl is-active bluetooth
```

Expected:

```text
enabled
active
```

---

## Important Note

Disabling the Bluetooth service does not physically disable the Bluetooth hardware.

It prevents the Bluetooth service from starting automatically and stops the Bluetooth functionality provided by the service.

If Bluetooth hardware needs to be disabled at a lower level, such as through firmware, kernel parameters, or hardware controls, that is a separate configuration and is outside the scope of this guide.

Once this configuration is complete, continue with [Security](05-security.md).
