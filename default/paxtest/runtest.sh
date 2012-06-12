#!/bin/sh

# Build.
make linux >/dev/null 2>/dev/null
if [ ! -f ./paxtest ]; then
  echo "Something went wrong during paxtest build."
  exit -1
fi

# Run tests
./paxtest blackhat > results.txt

# Parse results
## TODO


# Clean up.
rm -f core.*

rm -f results.txt
