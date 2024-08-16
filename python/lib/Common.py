from lib import Logging

def getVersion(str, delimiter='[.]'):
  versionSplit = str.split(delimiter)
  versionObj = {
    "major": versionSplit[0],
    "minor": versionSplit[1],
    "bug": versionSplit[2]
  }