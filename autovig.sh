#!/bin/bash

a="ABCDEFGHIJKLMNOPQRSTUVWXYZ"

[[ "${1}" == "" ]] &&
echo "Usage: $0 <txtfile>" && exit 1
m=${2:+-};

t=$(cat $1);
printf "\n";
lengtht=${#t}

printf "keyphrase: ";read  k;

#accept input with small letter or space
k=$(echo $k | tr -d [:space:] | tr [:lower:] [:upper:])

#getting length of key to create stream
lengthkey=${#k};
k=${k:0:lengthkey}${t:0:$((lengtht-lengthkey))}; 

for ((i=0;i<${#t};i++)); do
p1=${a%%${t:$i:1}*};
p2=${a%%${k:$((i%${#k})):1}*};
d="${d}${a:$(((${#p1}${m:-+}${#p2})%${#a})):1}"
done
echo "$d" > autocipher.tmp


