#!/bin/sh
#
# Licensed under the terms of the GNU GPL License version 2

if [ -f bin/$(uname -m)-linux-gnu/$(scripts/config) ]; then
	make rerun
else
	make
	make results
fi

cd results
make summary

exit 0
