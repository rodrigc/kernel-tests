#!/bin/bash

set -e

source ../../utils/root-check.sh
source ../../utils/build-deps.sh

check_root
is_root=$?
if [ $is_root -ne 0 ]; then
	exit 3
fi

# Clone and build LTP
check_dep autoconf
check_dep git
check_dep automake
check_dep make

git clone git://ltp.git.sourceforge.net/gitroot/ltp/ltp
pushd ltp
make autotools
./configure
make all

# Call the stress test scripts now

# XXXXXX

popd

# Cleanup
rm -rf ltp
