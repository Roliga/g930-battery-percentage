g930-battery-percentage: main.c
	gcc main.c -Wall -g -I/usr/include/hidapi -lhidapi-hidraw -o g930-battery-percentage

clean:
	rm g930-battery-percentage

install: install-battery-percentage install-notification-service install-udev

install-battery-percentage:
	install -D -m0755 g930-battery-percentage                  ${DESTDIR}/usr/bin/g930-battery-percentage

install-notification-service:
	install -D -m0755 g930-battery-notify                      ${DESTDIR}/usr/bin/g930-battery-notify
	install -D -m0644 systemd/user/g930-battery-notify.service ${DESTDIR}/usr/lib/systemd/user/g930-battery-notify.service
	install -D -m0644 systemd/user/g930-battery-notify.timer   ${DESTDIR}/usr/lib/systemd/user/g930-battery-notify.timer

install-udev:
	install -D -m0644 sysusers.d/g930-battery.conf             ${DESTDIR}/usr/lib/sysusers.d/g930-battery.conf
	install -D -m0644 udev/70-g930-battery.rules               ${DESTDIR}/usr/lib/udev/rules.d/70-g930-battery.rules

uninstall: uninstall-battery-percentage uninstall-notification-service uninstall-udev

uninstall-battery-percentage:
	rm -f ${DESTDIR}/usr/bin/g930-battery-percentage

uninstall-notification-service:
	rm -f ${DESTDIR}/usr/bin/g930-battery-notify
	rm -f ${DESTDIR}/usr/lib/systemd/user/g930-battery-notify.service
	rm -f ${DESTDIR}/usr/lib/systemd/user/g930-battery-notify.timer

uninstall-udev:
	rm -f ${DESTDIR}/usr/lib/sysusers.d/g930-battery.conf
	rm -f ${DESTDIR}/usr/lib/udev/rules.d/70-g930-battery.rules
