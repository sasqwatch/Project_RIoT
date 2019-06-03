#!/usr/bin/env python3

import requests,sys

cyan='\u001b[96m'
red='\u001b[91m'
green='\u001b[92m'
magenta='\u001b[95m'
default='\u001b[0m'

def check():
   try:
      targ=str(sys.argv[1])
      port=int(sys.argv[2])
      newtarg="http://{}:{}".format(targ,port)
      data=requests.get(newtarg)
      code=str(data.status_code)
      if code == '200':
        print("{}>{}|{}http_code: {} {}|{}>{} Check {}".format(cyan,green,red,code,green,cyan,default,newtarg))
   except KeyboardInterrupt:
      print("Module stopped")
check()
