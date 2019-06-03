#!/bin/bash

# Printer detection script

cyan='\e[96m'
red='\e[91m'
green='\e[92m'
yellow='\e[93m'
default='\e[0m'

found=`cat deviceType.txt`
found_port=`cat httpport.txt`

echo -en "$yellow=>$default Starting printer detection script against $cyan$found \n"

ifacelook=`curl -sSL http://$found:$found_port`
echo $found | grep "Copyright(C) 2000-2012 Brother Industries" &>/dev/null
if [ $? -eq 0 ];then
  echo -en "$cyan>$green|${red}printer$green|$cyan>$default This device is a printer check: http://$found:$found_port \n"
else
  printerports=(515 9100)
  for prif in ${printerports[*]}
  do
     nc -z -w 1 $found $prif &>/dev/null
     if [ $? -eq 0 ];then
       echo -en "$cyan>$green|${red}printer$green|$cyan>$default This device probably a printer.\n"
     else
       echo -en "$cyan>$green|${red}printer$green|$cyan>$default Port: $prif not found..\n"
     fi
  done
fi 
