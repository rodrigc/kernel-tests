#!/bin/bash
#
# Licensed under the terms of the GNU GPL License version 2

# This test came from rhbz 1013466

# Make sure we can run this test successfully
source ../../utils/root-check.sh
check_root
is_root=$?
if [ "$is_root" -ne "0" ]; then
        exit 3
fi

selinux=`getenforce`
if [ "$selinux" != "Enforcing" ]; then
	echo "SELinux must be enabled for this test"
	exit 3
fi

#Build
gcc -g -O0 -o mmap_test mmap_test.c
if [ ! -f ./mmap_test ]; then
  echo "Something went wrong during mmap_test build."
  exit -1
fi

./mmap_test

avcdenial=`ausearch -m AVC -ts recent | grep -c mmap_zero`
if [ "$avcdenial" -ne "0" ]; then
        echo "AVC Denail found for mmap_zero"
	exit -1
fi


exit 0
