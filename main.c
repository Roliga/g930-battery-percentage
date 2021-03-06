#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "hidapi.h"

#define BATTERY_MAX 91
#define BATTERY_MIN 44

int main(int argc, char* argv[])
{
	int i;
	int res;
	hid_device *handle;

	unsigned char buf[64] = {0xFF, 0x09, 0, 0xFD, 0xF4, 0x10, 0x05, 0xB1, 0xBF, 0xA0, 0x04, 0x00, 0, 0, 0, 0};
	for (i = 16; i < 64; i++)
		buf[i] = 0;

	handle = hid_open(0x046d, 0x0a1f, NULL);
	if (handle == NULL) {
		fprintf(stderr, "Failed to open device\n");
		return 1;
	}

	res = hid_send_feature_report(handle, buf, 64);
	if (res < 0) {
		fprintf(stderr, "Failed to send feature report: %ls\n", hid_error(handle));
		return 1;
	}

	for (i = 0; i < 3; i++) {
		res = hid_get_feature_report(handle, buf, 64);

		if (res < 0) {
			fprintf(stderr, "Failed to get feature report %d: %ls\n", i, hid_error(handle));
			return 1;
		}

		if (i < 2) {
			usleep(100000);
		}
	}

	unsigned int batteryPercent = (buf[13] - BATTERY_MIN) * 100 / (BATTERY_MAX - BATTERY_MIN);

	printf("%d\n", batteryPercent);

	hid_close(handle);
	hid_exit();

	return 0;
}
