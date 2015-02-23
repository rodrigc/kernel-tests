#!/bin/sh
#
# Licensed under the terms of the GNU GPL License version 2

# Test posix timers

# Build source if it is not already built
if [ ! -f ./posix_timers ]; then
	gcc -o posix_timers posix_timers.c -lrt
	if [ "$?" -ne "0" ]; then
		echo "posix_timers build failed."
		exit 3
	fi
fi

# Run the test
./posix_timers
if [ "$?" -ne "0" ]; then
	exit -1
fi
