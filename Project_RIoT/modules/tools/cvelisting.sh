#!/bin/bash

# CVE listing script

cyan='\e[96m'
red='\e[91m'
green='\e[92m'
default='\e[0m'

file="cvelist.txt"

echo -en $cyan" _________________________ \n"
echo -en $red"|                         | \n"
echo -en $red"|"$green"     AVAILABLE CVE's"$red"     | \n"
echo -en $red"|"$cyan"_________________________"$red"| \n\n$default"

cat cvelist.txt | grep -o "CVE-[0-9]*-[0-9]*"
echo "-------------------------"
rm -rf cvelist.txt
