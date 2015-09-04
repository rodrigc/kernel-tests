#!/bin/sh
#
# Licensed under the terms of the GNU GPL License version 2

# RCU Torture test for 10 minutes

# Test paramaters
if [ -z "$TORTURE_FOR" ]; then
    TORTURE_FOR=600
fi

# any extra kernel module parameters
if [ -z "$TORTURE_PARAMS" ]; then
    TORTURE_PARAMS=""
fi

# Make sure the rcutorture module is available to test
modprobe rcutorture $TORTURE_PARAMS
if [ $? -eq 0 ]; then
	echo "modprobe rcutorture $TORTURE_PARAMS passed"
else
	echo "modprobe rcutorture $TORTURE_PARAMS failed"
	exit 3
fi

source ../../utils/mod-check.sh
module=rcutorture
check_mod
has_mod=$?
 
if [ "$has_mod" -ne "0" ]; then
	exit 3
fi

# Test for $TORTURE_FOR time 
sleep $TORTURE_FOR
rmmod rcutorture
if [ $? -eq 0 ]; then
	echo "rmmod rcutorture $TORTURE_PARAMS passed"
else
	echo "rmmod rcutorture $TORTURE_PARAMS failed"
fi

# Check Results
dmesg | grep -i rcu | grep -i end | grep -i success > /dev/null
if [ $? -ne 0 ]; then
	exit -1
fi
