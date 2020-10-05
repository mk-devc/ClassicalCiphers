#!/bin/bash


if [ $# != 1 ]
then
echo "invalid $0 <txtfile>"
else
echo "" > $1.tmp


P="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
echo -n  "Enter shift value for key: "
read shiftVal

# get a shift value 
# neeed to concatenate to take the remaining front values
C=${P:shiftVal:26}${P::shiftVal} 
echo $C
# lower case trasnalte to upper space , -d is delete mapped spaces
# change $1 for one parameter $@ for all the paramter
hello=$(cat $1 | tr -d [:space:] | tr [:lower:] [:upper:] | tr $P $C)
echo "Encrypted text is "  $hello

## pefrom decryption

plaintext=$(echo $hello | tr $C $P)
echo "Decrypted text " $plaintext


fi
