#!/bin/bash

total_count(){

	total=$( ( cat $1 |tr -d [:space:] | tr [:lower:] [:upper:] ) )
	echo ${#total}
}


if [ $# != 1 ]
then 
	echo "Usage: $0 <txtfile>"
else
# if file doesnt exit create , else overwrite , >> append to the existing file
	echo "" > $1.tmp

total_words=$(total_count $1)
echo $total_words

for i in {A..Z}
do
	# we convert lower to upper 
	echo -n "$i " >> $1.tmp
	letter=$(cat $1 | tr [:lower:] [:upper:] | grep -o $i | wc -l)
	echo $(echo "scale=5; $letter/$total_words" | bc) >> $1.tmp

done
# sort ,-n  numerical order, -r reverse order for  ascedning when sorted, o for 
# write output , -k for keys 
sort -n -r -k 2 $1.tmp -o $1.tmp

fi
