
#!/bin/bash

create_ref_table(){
	echo "" > table.txt
	counter=0
	for x in {A..Z}; do  echo -n "$x " >> table.txt; echo $((counter++)) >> table.txt; done
	cat table.txt
}

display_table(){
	cat table.txt | column -t
}


ord(){ #converts decimal to character
	val=$(($(printf '%d' "'$index")-65))
	echo $val
}

#unused variable
val=$(create_ref_table)

if [ $# != 1 ]
then
	echo "invalid $0 <txtfile>"
else
	echo "" > $1.tmp
	# for saving key
	if [[ -f  key.tmp ]]
	then
		echo "" > key.tmp
	fi 

	flag=0
	declare -a indexList
	P="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	keyArray=($(for i in $(seq 26); do echo -n '+ ' | grep -o . ;done))
	while [[ flag != 1 ]] 
	do
		#echo $(display_table)
		echo -n  "Enter value for key: "
		read keyValue
		

		echo -n "Enter position in text domain: "
		read index

		# keeping an array in indexes
		i=$(ord $index)
		echo  $i
		if [[ ! $i -ge 0 && $i -le  25 ]]
		then
			echo "Wrong input specified"
			exit 1 
		fi
		#echo "this is index $i"
		#echo "this is list of index being recorded" " ${indexList[@]}"
		echo ""

		if [[ "${indexList[@]}" =~ "$i" ]]
		then 
			echo "key position in use"
			echo -n "are you sure you want to replace it ? (y/n)"
			read  resume
			if [[ $resume = "y" || $resume = "Y" || $resume = "yes" || $resume = "Yes" || $resume = "YES" ]]
			then
				
				keyArray[$i]=$keyValue
				C=$(echo ${keyArray[@]} | tr -d [:space:] )
		                echo "check key ${C}"
				echo "check map table ${P}"
				## pefrom decryption
				echo ""
				plaintext=$(cat $1 | tr $P $C)
				echo "=================================================Show Decrypted Text==================================================="
				echo $plaintext
				echo "======================================================================================================================="
			else
				continue; 
			fi
		else
				indexList+=" $i"
				
				keyArray[$i]=$keyValue
				C=$(echo ${keyArray[@]} | tr -d [:space:] )
		                echo "check key ${C}"
				echo "check map table ${P}"
				## pefrom decryption
				echo ""
				plaintext=$(cat $1 | tr $P $C)
				echo "=================================================Show Decrypted Text==================================================="
				echo $plaintext
				echo "======================================================================================================================="
		
		fi
		# save key
		((++count))
		echo -n "Would you like to save your progress ?(y/n)"
		read save 
		if [[ $save = "y" ||  $save = "Y" || $save = "Yes" || $save = "YES" || $save = "yes" ]]
		then 
			echo "$count""st try "$C >> key.tmp
		else
			continue;
		fi
	done
fi
