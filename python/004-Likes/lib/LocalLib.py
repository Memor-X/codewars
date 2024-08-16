########################################
#
# File Name:	LocalLib.ps1
# Date Created:	15/08/2024
# Description:	
#	Local Functions for Unit Testing
#
########################################

# File Imports
import sys, os 
dir_path = os.path.dirname(os.path.realpath(__file__))
sys.path.insert(0,dir_path+"/../..")
from lib.Common import *
#=======================================

# Global Variables

#=======================================

def likes(names):
    nameCount = len(names)
    rtnString = ""
    if nameCount < 1:
        rtnString = "no one likes this"
    elif nameCount == 1:
        rtnString = names[0] + " likes this"
    elif nameCount == 2:
        rtnString = " and ".join([names[0],names[1]]) + " like this"
    else:
        rtnString = ", ".join([names[0],names[1]]) + " and "
        if nameCount > 3:
            rtnString += str(nameCount-2) + " others"
        else:
            rtnString += names[2]

        rtnString += " like this"

    return rtnString