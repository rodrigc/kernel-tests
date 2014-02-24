#!/bin/bash
#
# Licensed under the terms of the GNU GPL License version 2

source ../../utils/loopback.sh

pushd ltp
export PATH=$PATH:`pwd`/testcases/kernel/io/direct_io/

# Setup a filesystem we know will support dio, since LTP sucks and assumes /tmp
# is a real filesystem
img_file=`mktemp`

# It also sucks in that you can't tell it via options to NOT use /tmp for its
# files.  So we have to temporarily mount our fake image over top.  Irritation.
#mount_dir=`mktemp -d`
mount_dir="/tmp"
loopback_fs $img_file 1024 ext4 $mount_dir
if [ $? -ne 0 ]
then
	echo "Could not create loopback filesystem"
	exit 3
fi

pushd $mount_dir

## Complete a default run.
diotest1
diotest2
diotest3
diotest4
diotest5
diotest6

## Run the tests with larger buffersize
diotest1 -b 65536
diotest2 -b 65536
diotest3 -b 65536
diotest4 -b 65536
diotest5 -b 65536
diotest6 -b 65536

### Run the tests with larger iterations
diotest1 -b 65536 -n 2000
diotest2 -b 65536 -i 1000
diotest3 -b 65536 -i 1000
diotest5 -b 65536 -i 1000
diotest6 -b 65536 -i 1000

## Run the tests with larger offset - 1MB
diotest2 -b 65536 -i 1000 -o 1024000
diotest3 -b 65536 -i 1000 -o 1024000
diotest5 -b 65536 -i 1000 -o 1024000
diotest6 -b 65536 -i 1000 -o 1024000

## Run the tests with larger offset - 100 MB
diotest2 -b 65536 -i 1000 -o 104857600
diotest3 -b 65536 -i 1000 -o 104857600
diotest5 -b 65536 -i 1000 -o 104857600
diotest6 -b 65536 -i 1000 -o 104857600

### Run tests with larger vector array
diotest6 -b 8192 -v 100
diotest6 -b 8192 -o 1024000 -i 1000 -v 100
diotest6 -b 8192 -o 1024000 -i 1000 -v 200
popd

# Cleanup
umount $mount_dir
rm $img_file

popd

