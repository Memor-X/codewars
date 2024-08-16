import sys

def log(msg, indents = 0, key = "LOG"):
  sys.stdout.write("[" + key + "] " + msg + "\n")

def log_warning(msg, indents = 0):
  log(msg,indents,"WARNING")

def log_error(msg, indents = 0):
  log(msg,indents,"ERROR")

def log_success(msg, indents = 0):
  log(msg,indents,"SUCCESS")

def log_debug(msg, indents = 0):
  log(msg,indents,"DEBUG")

def log_start():
  log("Script Start")

def log_end():
  log_success("Script End")