#!/bin/bash

create_sparse_file() {
	dd if=/dev/zero of=$1 bs=1 count=0 seek=$2M ;
	return $?
}

create_fs() {
	loopdev=`losetup --find --show $2`;
	echo $loopdev
	mkfs -t $1 $loopdev ;
	losetup --detach $loopdev
	return $?
}

mount_image() {
	mount -t $1 -o loop $2 $3 ;
	return $?
}

loopback_fs() {
	file=$1;
	size=$2;
	fs=$3;
	mountpoint=$4;

	create_sparse_file $file $size;
	rc=$?
	if [ $rc -ne 0 ]
	then
		echo "Could not create spare file $file"
		return 3
	fi

	create_fs $fs $file
	if [ $rc -ne 0 ]
	then
		echo "Could not create $fs on $file"
		return 3
	fi
	
	mount_image $fs $file $mountpoint
	if [ $rc -ne 0 ]
	then
		echo "Could not mount $fs filesystem on $file at $mountpoint"
		return 3
	fi

	return 0
}	
