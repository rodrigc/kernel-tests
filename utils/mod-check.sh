#!/bin/bash

check_mod() {
	if [ $(lsmod | grep -wc $module ) -eq 0 ]
	then
		echo "Module not present, skipping"
		return 3
	fi
	return 0
}
