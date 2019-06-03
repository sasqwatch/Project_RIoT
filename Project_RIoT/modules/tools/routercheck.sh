#!/bin/bash

# Router checking script

cyan='\e[96m'
red='\e[91m'
green='\e[92m'
default='\e[0m'

target_ip=`cat deviceType.txt`
target_port=`cat httpport.txt`

rout=`curl -sSL http://$target_ip:$target_port`
routerwords=(`cd ..; cd keywords;  cat routerwords.txt`)

for rw in ${routerwords[*]}
do
   echo $rout | grep "$rw" &>/dev/null
   if [ $? -eq 0 ];then
     echo -en "$cyan>$green|${red}router$green|$cyan>$default Found word: $rw check -> http://$target_ip:$target_port\n"
   fi
done
