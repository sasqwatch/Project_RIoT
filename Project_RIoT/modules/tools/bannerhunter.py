#!/usr/bin/env python3

# Banner grabbing script

cyan='\u001b[96m'
red='\u001b[91m'
green='\u001b[92m'
yellow='\u001b[93m'
default='\u001b[0m'

import socket,sys,os

def grabber():
   try:
      host=str(sys.argv[1])
      port=int(sys.argv[2])
      sock=socket.socket()
      sock.connect((host,port))
      banner = str(sock.recv(1024).decode("ascii"))
      save="echo {} > banners.txt".format(banner)
      os.system(save)
      print("{}[{}+{}]{} Banner information: {}{}".format(cyan,red,cyan,default,green,banner))
      print("{}=>{} Waiting for available cve list".format(yellow,default))
      sock.close()
   except:
      return
grabber()
