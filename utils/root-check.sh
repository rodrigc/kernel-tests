#!/bin/bash

check_root() {
	if [ $(id -u) -ne 0 ]
	then
		echo "You need to be root to run this test"
		return 3
	fi
	return 0
}
