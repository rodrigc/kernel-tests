#!/bin/sh

check_kill()
{
	str="$*"

	C=$(grep "$str" results.txt | grep Killed | wc -l)
	if [ $C -eq 0 ]; then
		grep "$str" results.txt
		exit -1
	fi
}

# Build.
make linux >/dev/null 2>/dev/null
if [ ! -f ./paxtest ]; then
  echo "Something went wrong during paxtest build."
  exit -1
fi

# Run tests
./paxtest blackhat > results.txt

# Parse results

ARCH=$(uname -m)

if [ "$ARCH" == "x86_64" ]; then

	check_kill "Executable anonymous mapping"
	check_kill "Executable bss"
	check_kill "Executable data"
	check_kill "Executable heap"
	check_kill "Executable stack"
	check_kill "Executable shared library bss"
	check_kill "Executable shared library data"

	# as long as SELinux is enabled, this test will pass.
	check_kill "Executable heap (mprotect)"

#	check_kill "Executable anonymous mapping (mprotect)"
#	check_kill "Executable bss (mprotect))"
#	check_kill "Executable data (mprotect)"
#	check_kill "Executable stack (mprotect))"
#	check_kill "Executable shared library bss (mprotect)"
#	check_kill "Executable shared library data (mprotect)"

#	check_kill "Writable text segments"

#	check("Return to function (strcpy)")              : paxtest: return address contains a NULL byte.
#	check("Return to function (strcpy, PIE)")         : paxtest: return address contains a NULL byte.

	check_kill "Return to function (memcpy)"
	check_kill "Return to function (memcpy, PIE)"

else
	echo FIXME: Unsupported ARCH: $(uname -m)
	cat results.txt
	exit -1
fi


# Clean up.
rm -f core.*

rm -f results.txt
