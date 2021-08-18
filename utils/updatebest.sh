#!/bin/sh
# 
# This script compares the latest benchmark result with the best found so far
# If any improvement is found the current binaries are copied to the bestof/
# directory.
#
# Used after 'gmake ref', and before new compiler options are to be tried
#
# If the bestof/ directory is empty or non-existent it is created and the
# current binaries are copied there.
#
# Happy benchmarking!
#
# //Tapsa
#

if [ ! -f resultfile.txt ]
then
	echo resultfile.txt not found.
	echo You need to run the benchmark and execute this script from that directory.
	exit -1
fi

if [ ! -d bestof ] 
then
	mkdir bestof
fi

if [ ! -f bestof/bestresults.txt ]
then
	echo Score: 0.000000 times a Sun Ultra 10 > bestof/bestresults.txt
        echo Score: 0.000000 times a Sun Ultra 10 >> bestof/bestresults.txt
        echo Score: 0.000000 times a Sun Ultra 10 >> bestof/bestresults.txt
        echo Score: 0.000000 times a Sun Ultra 10 >> bestof/bestresults.txt
        echo Score: 0.000000 times a Sun Ultra 10 >> bestof/bestresults.txt
        echo Score: 0.000000 times a Sun Ultra 10 >> bestof/bestresults.txt
        echo Score: 0.000000 times a Sun Ultra 10 >> bestof/bestresults.txt
fi
	
c=1

for i in analyzer fourinarow mason pcompress2 pifft distray neural
do
	new=`grep Score resultfile.txt | head -$c | tail -1 | cut -d ' ' -f 2`
	old=`head -$c bestof/bestresults.txt | tail -1 | cut -d ' ' -f 2`
	X=`echo $new $old | awk '{ if ($1 > $2) printf "1"; else printf "0" }'`
	if [ $X -eq 1 ]
	then
        	echo Score $new  times a Sun Ultra 10 >> bestof/temp
        	cp benchmarks/$i/$i bestof/
		echo $i :	Updated result to $new \(old was ${old}\)
	else
        	echo Score $old times a Sun Ultra 10 >> bestof/temp
		echo $i :	Old score of $old better than current $new
	fi
	c=`expr $c + 1`
done

cp -f bestof/temp bestof/bestresults.txt
rm -f bestof/temp

