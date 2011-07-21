export HISTSIZE=20000
export CYGWIN=nodosfilewarning
export C=/cygdrive/c
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]*\h* \[\e[33m\]\w\[\e[0m\]\n\$ '

shopt -s cdable_vars

alias ll='ls -l'

# Executes all args as a command and captures stdin/stdout to the default desktop log file
# For example, the following will perform a long listing and save the results to $DT/log.txt:
#   log ls -l
# If no args are given, opens the default desktop log file
log() {
  if [ 0 = $# ]; then
    less $DT/log.txt
  else
    $@ 2>&1 | tee $DT/log.txt
  fi
}

start() {
  cmd /c start "$@"
}

dt() {
  cd $DT
}

