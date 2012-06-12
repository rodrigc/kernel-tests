#!/bin/bash

date=$(date +%s)
topdir=$(pwd)
logfile=$topdir/logs/kernel-test-$date.log
verbose=n
testset=default

kver=$(uname -r)
release=$(cat /etc/redhat-release)

# Check for pre-requisites.
if [ ! -f /usr/bin/gcc ]; then
	echo Fedora kernel test suite needs gcc.
	exit
fi


if [ ! -d "$topdir/logs" ] ; then
	mkdir $topdir/logs
fi

args=y

while [ $args = y ]
do
        case "$1" in
	-v)
		#TO DO: Implement verbose behavior
		verbose=y
		shift 1
		;;
	-t)
		testset=$2
		shift 2
		;;
	*)
		args=n
	esac
done

case $testset in
minimal)
	dirlist="minimal"
	;;
default)
	dirlist="minimal default"
	;;
stress)
	dirlist="minimal default stress"
	;;
destructive)
	echo "You have specified the destructive test set"
	echo "This test may cause damage to your system"
	echo "Are you sure that you wish to continue?"
	read continue
	if [ $continue == 'y' ] ; then
		dirlist="minimal default destructive"
	else
		dirlist="minimal default"
		testset=default
	fi
	;;
*)
	echo "supported test sets are minimal default stress or destructive"
	exit 1
esac


#Basic logfile headers
echo "Date: $(date)" > $logfile
echo "Test set: $testset" >> $logfile
echo "Kernel: $kver" >> $logfile
echo "Release: $release" >> $logfile
echo "============================================================" >>$logfile



#Start running tests
echo "Test suite called with $testset"

for dir in $dirlist
do
	for test in $(find ./$dir/ -name runtest.sh)
	do
		testdir=$(dirname $test)
		pushd $testdir &>/dev/null
		#TO DO:  purpose file test name format
		testname=$testdir
		echo "Starting test $testname" >> $logfile
		./runtest.sh &>>$logfile
		complete=$?
		case $complete in
		0)
			result=PASS
			;;
		3)
			result=SKIP
			;;
		*)
			result=FAIL
		esac
		printf "%-65s%-8s\n" "$testname" "$result"
		popd &>/dev/null
	done
done
