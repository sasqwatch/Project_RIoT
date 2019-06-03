#!/usr/bin/env python3

#------------COLOR AND FONT AREA-------------@
lg1='\u001b[92m'
lg2='\u001b[102m'
lr1='\u001b[91m'
lr2='\u001b[101m'
lbl2='\u001b[104m'
def2='\u001b[49m'
black1='\u001b[30m'
lc1='\u001b[96m'
ly1='\u001b[93m'
ly2='\u001b[103m'
lm1='\u001b[95m'
w1='\u001b[0m'
defbl='\u001b[49m'

screen='''
###################################################
#                           ||                    #
# █▄▄▄▄ ▄█ ████▄    ▄▄▄▄▀   || IoT Security Audit #
# █  ▄▀ ██ █   █ ▀▀▀ █      ||       Tool         #
# █▀▀▌  ██ █   █     █      ||                    #
# █  █  ▐█ ▀████    █       ||     By CYB3RMX_    #
#   █    ▐         ▀        ||--------------------#
#  ▀                        ||    version: 1.0    #
###################################################
'''
import os,sys,requests

class start_RIoT():
   def scan_random_ip():
      print("{}[{}+{}]{} Initializing random scanner module...".format(lc1,lr1,lc1,w1))
      randip=str(os.system("cd modules/tools/; ./ipgenerator.sh --random"))
      print("\n{}[{}+{}]{} Initializing target scanner module...".format(lc1,lr1,lc1,w1,randip))
      os.system("cd modules/tools/; ./target_recon.sh")
   def selector():
      argx=str(sys.argv[1])
      if argx == '--random-scan':
        start_RIoT.scan_random_ip()
      elif argx== '--loop-scan':
        print("\n{}[{}+{}]{} Starting loop scan mode...".format(lc1,lr1,lc1,w1))
        while True:
           try:
              start_RIoT.scan_random_ip()
           except KeyboardInterrupt or EOFError:
              print("\n{}[{}!{}]{} Program stopped...".format(lc1,lr1,lc1,w1))
              sys.exit(1)
      elif argx == '--specific-scan':
        mytarg=str(sys.argv[2])
        strin="cd modules/tools/; echo {} > temp.txt".format(mytarg)
        os.system(strin)
        print("\n{}[{}+{}]{} Initializing target scanner module...".format(lc1,lr1,lc1,w1))
        os.system("cd modules/tools/; ./target_recon.sh")
      elif argx == '--help':
        print("Usage: python3 riot.py [ARGUMENTS] [TARGET] \n")
        print("------------ARGUMENT_LIST-------------")
        print("--random-scan: Scanning world wide random devices 1 times |takes no target arg.|")
        print("--loop-scan: Scanning random devices in loop mode |takes no target arg.|")
        print("--specific-scan: Scan specified device |need target arg.|")
        print("--help: Print this output :) ")
        print("--------------------------------------")
      else:
        print("Please type --help to see available arguments...")
print(screen)
try:
   start_RIoT.selector()
except IndexError:
   print("Please type --help to see available arguments...")
