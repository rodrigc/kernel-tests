#!/bin/sh
COUNT=$(for i in `seq 1 1000` ; do grep stack /proc/self/maps; done  | sort -u | uniq -c | wc -l)

if [ $COUNT -lt 950 ]; then
  echo "Stack randomness changes < 95% of the time ($COUNT)"
  exit -1
else
  exit 0
fi
