#!/bin/bash

set -e

pushd ltp
export PATH=$PATH:`pwd`/testcases/kernel/mem/mtest01/:`pwd`/testcases/kernel/mem/mtest01/:`pwd`/testcases/kernel/mem/mmapstress/:`pwd`/testcases/kernel/mem/page/:`pwd`/testcases/kernel/syscalls/mmap/:`pwd`/testcases/kernel/mem/mtest05/:`pwd`/testcases/kernel/mem/mtest06/:`pwd`/testcases/kernel/mem/vmtests/:`pwd`/testcases/kernel/mem/shmt/

mmap001 -m 10000
mmap001
mtest01 -p80
mtest01 -p80 -w
mmstress
mmap1 -x 0.05

# This runs for a long time.  Revisit
# mmap-corruption01 -h1 -m1 -s1

page01
page02

data_space
stack_space

shmt02
shmt03
shmt04
shmt05
shmt06
shmt07
shmt08
shmt09
shmt10

popd

