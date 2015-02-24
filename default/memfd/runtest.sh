#!/bin/sh
#
# Licensed under the terms of the GNU GPL License version 2

# Test the memfd mechanism

# build the test source 
if [ ! -f ./memfd_test ]; then
	gcc -D_FILE_OFFSET_BITS=64 -o memfd_test memfd_test.c
	if [ "$?" -ne "0" ]; then
		echo "memfd_test build failed."
		exit 3
	fi
fi

# Run the test
./memfd_test
if [ "$?" -ne "0" ]; then
	exit -1
fi
