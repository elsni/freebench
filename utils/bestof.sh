#!/bin/sh
# 
# This script runs a benchmark with the best found binaries so far
#

if [ ! -d bestof ]
then
	echo You don\'t have a bestof directory of best-so-far files.
	echo This directory is created by the updatebest.sh script.
	exit -1
fi

for i in analyzer fourinarow mason pcompress2 pifft distray neural
do
	cp bestof/$i benchmarks/$i/	
done

./utils/run.sh ref 2> resultfile.txt
./utils/fbparser ref < resultfile.txt > result.html

