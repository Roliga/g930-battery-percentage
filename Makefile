g930-battery-percentage: main.c
	gcc main.c -Wall -g -I/usr/include/hidapi -lhidapi-hidraw -o g930-battery-percentage
