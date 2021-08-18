#!/bin/sh

# Calculates the geometric average of the results in a given file

if [ X$1 = X ] 
then
	file=resultfile.txt
else
	file=$1
fi

if [ ! -f $file ]
then
	echo File $file not found.
	exit -1
fi

printf "%s" 'e((1/7)*l(' > a
a=1

for i in `grep Score $file | cut -d ' ' -f 2`
do
	a=$a\*$i
done

printf "%s" $a >> a

echo '))' >> a

bc -l < a
rm a
