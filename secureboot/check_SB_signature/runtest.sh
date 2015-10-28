#!/bin/sh
#
# Licensed under the terms of the GNU GPL License version 2

# Check the Secure Boot Signer

# Make sure pesign is available
if [ ! -f /usr/bin/pesign ]; then
	echo "pesign is required to check the secure boot signature"
	exit 3
fi

validsig=$1
echo "Looking for Signature $validsig"
kver=$(uname -r)
signer=$(/usr/bin/pesign -i /boot/vmlinuz-$kver -S | grep "common name")
echo $signer
if [ "$signer" == "The signer's common name is $validsig" ]; then
	exit 0
else 
	exit -1
fi
