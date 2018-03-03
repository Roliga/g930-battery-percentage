g930-battery-percentage
=======================

This is a small command line utility that prints the battery percentage of a Logitech G930 wireless headset. A systemd user service is also provided to send desktop notifications when the battery level is low.

Build/Install
-------------

Install `hidapi` and optionally `libnotify` to provide `notify-send` for the notification service, then build and install with:

	make
	make install

Depending on your system you may need to run `udevadm control --reload-rules` for the udev rules to apply.

If the program needs to be run outside a user session (from ssh for example), the user must be added to the `plugdev` group.
