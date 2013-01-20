#!/bin/bash

# This function will check to see if a module is loaded. It is usefule
# for tests which require specific modules or hardware.  If a module
# is not loaded, the result should typically be a skip, not a failure.
# Example usage in your runtest.sh:
#
# source ../../utils/mod-check.sh
# module=foobar
# check_mod
# has_mod=$?
# 
# if [ "$has_mod" -ne "0" ]; then
#         exit 3
# fi


check_mod() {
	if [ $(lsmod | grep -wc $module ) -eq 0 ]
	then
		echo "Module not present, skipping"
		return 3
	fi
	return 0
}
