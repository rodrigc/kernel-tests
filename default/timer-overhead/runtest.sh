#!/bin/sh

if [ ! -f ./timer-test ]; then
	make
	if [ "$?" -ne "0" ]; then
		echo "Timer-test build failed."
		exit -1
	fi
fi

./timer-test
if [ "$?" -ne "0" ]; then
	echo "Test failure."
	exit -1
fi
