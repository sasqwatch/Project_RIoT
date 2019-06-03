#!/bin/bash

# Proxy port checking script

cyan='\e[96m'
red='\e[91m'
green='\e[92m'
yellow='\e[93m'
default='\e[0m'

targetip=`cat deviceType.txt`
echo -en "$yellow=>$default Starting proxy detection script against $cyan$targetip \n"
for ((l_start=8000;l_start<10000;l_start++))
do
  nc -z -w 1 $targetip $l_start &>/dev/null
  if [ $? -eq 0 ];then
    echo -en "$cyan>$green|${red}proxy$green|$cyan>$default Found port: $cyan${l_start} \n"
  fi
done
