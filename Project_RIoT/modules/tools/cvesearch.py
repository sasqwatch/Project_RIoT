#!/usr/bin/env python3

# CVE search script

import os
try:
   import pycvesearch
except ModuleNotFoundError:
   print("[!] Installing pycvesearch module...")
   os.system("git clone https://github.com/cve-search/PyCVESearch")
   os.system("cd PyCVESearch")
   os.system("chmod 777 setup.py")
   os.system("sudo ./setup.py install")
from pycvesearch import CVESearch

def searcher():
   try:
      cve = CVESearch()
      targetvuln=str(open('banners.txt','r'))
      morevuln=str(cve.search(targetvuln))
      newfile=open("cvelist.txt","w")
      newfile.write(morevuln)
      targetvuln.close()
      newfile.close()
   except:
      return
searcher()
