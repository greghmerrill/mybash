export PS1='\[\e]0;\w\a\]\n\[\e[32m\]*\h* \[\e[33m\]\w\[\e[0m\]\n\$ '
export HISTSIZE=20000

shopt -s cdable_vars

alias ll='ls -l'
alias sql='rlwrap -b "" -f ~/.sql.dict sqlplus'

# Executes all args as a command and captures stdin/stdout to the default desktop log file
# For example, the following will perform a long listing and save the results to $DT/log.txt:
#   log ls -l
# If no args are given, opens the default desktop log file
log() {
  if [ 0 = $# ]; then
    less $DT/log.txt
  else
    $@ 2>&1 | tee $DT/log.txt
    return $PIPESTATUS
  fi
}

# Navigates to the "Desktop"
dt() {
  cd $DT
}

export IS_CYGWIN=false
if [ "$(uname -a | grep -i cygwin)" ]; then
  export IS_CYGWIN=true
fi

if $IS_CYGWIN; then
  . ~/mybash/cygwin.sh
fi
