#!/bin/sh
#
# Licensed under the terms of the GNU GPL License version 2

ARCH=$(uname -m)

if [ "$ARCH" == "x86_64" ]; then
  COUNT=$(for i in `seq 1 1000` ; do grep stack /proc/self/maps; done  | sort -u | uniq -c | wc -l)
else
  exit 3
fi


if [ $COUNT -lt 950 ]; then
  echo "Stack randomness changes < 95% of the time ($COUNT)"
  exit -1
else
  exit 0
fi
