#!/bin/sh
#
# Licensed under the terms of the GNU GPL License version 2

# Running mq_notify/5-1 testcase from Open POSIX testsuite appears to lead to corrupted memory.
# This is later followed by various kernel crash/BUG messages.

if [ ! -f ./mq-notify ]; then
	gcc mq_notify-5.1.c -lrt -o mq-notify
	if [ "$?" -ne "0" ]; then
		echo "mq-notify build failed."
		exit 3
	fi
fi

for i in {1..10}
do 
	./mq-notify
	if [ "$?" -ne "0" ]; then
		echo "mw-notify test failure."
		exit -1
	fi
done
