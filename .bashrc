export PS1='\[\e]0;\w\a\]\n\[\e[32m\]*\h* \[\e[33m\]\w\[\e[0m\]\n\$ '
export HISTSIZE=20000

shopt -s cdable_vars

alias ll='ls -l'
alias sql='rlwrap -b "" -f ~/.sql.dict sqlplus'

# Executes all args as a command and captures stdin/stdout to the default desktop log file
# For example, the following will perform a long listing and save the results to $DT/log.txt:
#   log ls -l
# If no args are given, opens the default desktop log file
#
# Prior to the command arguments, the caller can optionally provide "-a".  This will
# append to $DT/log.txt instead of overwriting.
log() {
  local args=$@
  if [ "-a" = $1 ]; then
    local append="-a"
    args=${@#-a}
  fi

  if [ 0 = $# ]; then
    less $DT/log.txt
  else
    $args 2>&1 | tee $append $DT/log.txt
    return $PIPESTATUS
  fi
}

# Navigates to the "Desktop"
dt() {
  cd $DT
}

# Changes the current window title to the parameters passed
# Note that this change will not be retained if PS1 sets the window title
title() {
	echo -e "\033]2;$*\007"
}

# Overrides ssh to set the current window title to the given ssh host, then call ssh, then restore the window title
realssh=$(which ssh)
ssh() {
	title $*
	bash -c "$realssh $@"
}

export IS_CYGWIN=false
if [ "$(uname -a | grep -i cygwin)" ]; then
  export IS_CYGWIN=true
fi

if $IS_CYGWIN; then
  . ~/mybash/cygwin.sh
fi
