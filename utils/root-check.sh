#!/bin/bash
#
# Licensed under the terms of the GNU GPL License version 2

check_root() {
	if [ $(id -u) -ne 0 ]
	then
		echo "You need to be root to run this test"
		return 3
	fi
	return 0
}
