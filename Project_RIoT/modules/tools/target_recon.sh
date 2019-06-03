#!/bin/bash

# Target scanning script for RIoT

cyan='\e[96m'
red='\e[91m'
yellow='\e[93m'
default='\e[0m'
green='\e[92m'

targetip=`cat temp.txt`

echo -en "$yellow=>$default Starting scanner module against $cyan$targetip \n"

nc -v -z -w 1 $targetip 1 2>&1 | grep "Unknown host"

if [ $? -eq 0 ];then
  echo -en "$cyan[$red!$cyan]$default IP: $cyan$targetip$default doesn't exist...\n"
else
  echo $targetip > deviceType.txt
  portzz=(`cd ..; cd keywords; cat portnumbers.txt`)
  curl -sSL http://ip-api.com/$targetip
  echo " "
  for port in ${portzz[*]}
  do
     nc -z -w 1 $targetip $port &>/dev/null
     if [ $? -eq 0 ];then
       if [ $port -eq 21 ];then
         echo -en "\n$cyan[$red+$cyan]$default FTP port open...\n"
         python3 bannerhunter.py $targetip $port
         python3 cvesearch.py
         ./cvelisting.sh
       elif [ $port -eq 22 ];then
         echo -en "\n$cyan[$red+$cyan]$default SSH port open...\n"
         python3 bannerhunter.py $targetip $port
         python3 cvesearch.py
         ./cvelisting.sh
       elif [ $port -eq 23 ];then
         echo -en "\n$cyan[$red+$cyan]$default TELNET port open...\n"
         python3 bannerhunter.py $targetip $port
         python3 cvesearch.py
         ./cvelisting.sh
       elif [ $port -eq 25 ];then
         echo -en "\n$cyan[$red+$cyan]$default SMTP port open...\n"
         python3 bannerhunter.py $targetip $port
         python3 cvesearch.py
         ./cvelisting.sh
       elif [ $port -eq 53 ];then
         echo -en "\n$cyan[$red+$cyan]$default Domain port open...\n"
       elif [ $port -eq 80 ];then
         echo $port > httpport.txt
         echo -en "\n$cyan[$red+$cyan]$default HTTP port open...\n"
         python3 httpCode.py $targetip $port
         ./routercheck.sh
         ./printerdetect.sh
         ./webcamdetect.sh
       elif [ $port -eq 81 ];then
         for ((http=80;http<90;http++))
         do
            echo $http > httpport.txt
            echo -en "\n$cyan[$red+$cyan]$default HTTP port: $http open...\n"
            python3 httpCode.py $targetip $http
            ./routercheck.sh
            ./printerdetect.sh
            ./webcamdetect.sh
         done
       elif [ $port -eq 137 ];then
         echo -en "\n$cyan[$red+$cyan]$default Netbios port open...\n"
         echo -en "$cyan=$green|${red}137$green|$cyan>$default Target system maybe have windows machine.\n\n"
         python3 bannerhunter.py $targetip $port
         python3 cvesearch.py
         ./cvelisting.sh
       elif [ $port -eq 443 ];then
         sleep 2
         python3 httpCode.py $targetip 443
       elif [ $port -eq 445 ];then
         echo -en "\n$cyan[$red+$cyan]$default SMB port open...\n"
         echo -en "$cyan=$green|${red}445$green|$cyan>$default This target have samba file server\n"
         echo -en "$cyan=$green|${red}445$green|$cyan>$default This target probably a printer or connected with printer\n\n"
         ./printerdetect.sh
       elif [ $port -eq 554 ];then
         echo -en "\n$cyan[$red+$cyan]$default RTSP port open...\n"
         python3 bannerhunter.py $targetip $port
         pyhton3 cvesearch.py
         ./cvelisting.sh
         echo -en "$cyan=$green|${red}554$green|$cyan>$default This target probably some kind of camera or connected a camera.\n\n"
         ./webcamdetect.sh
       fi
     fi
  done
  ./proxyportcheck.sh
fi

rm -rf temp.txt
rm -rf httpport.txt
rm -rf deviceType.txt
rm -rf banners.txt
