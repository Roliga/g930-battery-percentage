g930-battery-percentage
=======================

This is a small command line utility that prints the battery percentage of a Logitech G930 wireless headset.

To build it manually, just install *hidapi* then run `make`.

The program needs access to the *hidraw* interface for the headset, so either run it as root, or add the appropriate udev rule by copying `udev/g930-battery-percentage` to `/etc/udev/rules.d/`, then run `udevadm control --reload-rules` and plug the headset out and in again. Any user with an active logind session should then be able to use the program. If the program needs to be run outside a session (via ssh, or from a systemd service), the user can be added to the `plugdev` group, which can either be manually created, or automatically by copying the `sysusers.d/g930-battery.conf` file to `/etc/sysusers.d/`.
