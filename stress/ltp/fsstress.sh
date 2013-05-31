#!/bin/bash

#set -e


pushd ltp
export PATH=$PATH:`pwd`/testcases/kernel/fs/fsx-linux/:`pwd`/testcases/kernel/fs/fsstress/:`pwd`/testcases/kernel/fs/racer/

( export TCbin=`pwd`/testcases/kernel/fs/fsx-linux; fsxtest02 100000 ) &
fsxpid=$!; echo "fsx-linux $fsxpid"

( mkdir fsstress.tmp; fsstress -d ./fsstress.tmp -l 10000 -n 20 -p 20 -v; rm -rf fsstress.tmp ) &
fsstresspid=$!; echo "fsstress $fsstresspid"

( pushd testcases/kernel/fs/racer/; fs_racer.sh -t 600; popd ) &
fsracerpid=$!; echo "fs_racer $fsracerpid"

rc=0
for pid in $fsxpid $fsstresspid $fsracerpid
do
	wait $pid
	if [ $? -ne 0 ]
	then
		echo "$pid failed"
		rc=3
	fi
done

popd

exit $rc
