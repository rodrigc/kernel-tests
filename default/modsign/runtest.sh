#!/bin/sh

source ../../utils/root-check.sh

check_root
is_root=$?
if [ "$is_root" -ne "0" ]; then
	exit 3
fi

# Run
./modsign_tests.sh
result=$?
if [ "$result" -ne "0" ]; then
	echo "Could not run tests"
	exit $result
fi
