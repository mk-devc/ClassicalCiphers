#!/bin/bash

################## A vignere cipher #############################

createTable(){
	P="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	declare -a matrix
	num_rows=25
	echo "" > tableV.tmp
	for ((i=0;i<=num_rows;i++)) 
	do	
	        matrix[$i]=${P:$i:26}${P::$i}
		echo ${P:$i:26}${P::$i} >> tableV.tmp
	done

	val="${matrix[@]}"
	echo $val
}

ord(){ #converts decimal to character
        val=$(($(printf '%d' "'$conv")-65))
        echo $val
}

chr(){  # convert from decimal to ascii
	printf \\$(printg '%3o' $char)
}


#decrypt(){}


if [ $# != 1 ]
then
        echo "invalid $0 <txtfile>"
else
        echo "" > $1.tmp
        # for saving key
	if [[ -f encrypt.tmp ]]
	then
		echo -n "Remove previous encrypted text?(y/n)";
		read approve;
	
	        if [[ $approve == "y" || $approve == "Y" ]]
	        then
	           echo  "" >  encrypt.tmp
	        fi
	else
		echo  "" >  encrypt.tmp;
	fi;		

	echo -n "Enter Key :"
	read  key;
	
	if [[ !("$key" =~ ^[a-zA-Z]+$) ]]
	then 
	     	echo "Input must be in letters from english text";
		exit 1;
	fi;
	key=${key^^};
	# create table
	table=( $(createTable) )
	# convert string to array	
	arr=( $(for i in $(seq 0 $((${#key}-1)));do echo ${key:$i:1};done) )
	# reading file from txt
	file=$(cat $1)
	l=$((${#file}))
	for (( i=0; i < $l; ++i ))
	do
		# for plaintext
		conv=${file:$i:1}
		col=$(ord $conv)

		#make it repeat using modulus
		index=$(($i%${#key}))
		conv=${arr[$index]}
		row=$(ord $conv)

		#fetch from table
		t=${table[$row]}
		t=${t:col:1}
		#echo $t
		echo -n $t >> encrypt.tmp;
	done

	echo "View encrypted text at encrypt.tmp"; 
fi
