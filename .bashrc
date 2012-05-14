export PS1='\[\e]0;\w\a\]\n\[\e[32m\]*\h* \[\e[33m\]\w\[\e[0m\]\n\$ '
export HISTSIZE=20000
export PATH=".:$PATH"

export LOG=~/.log.txt

shopt -s cdable_vars

alias ll='ls -l'
alias sql='rlwrap -b "" -f ~/.sql.dict sqlplus'

# Executes all args as a command and captures stdin/stdout to the default desktop log file
# For example, the following will perform a long listing and save the results to $LOG:
#   log ls -l
# If no args are given, opens the default desktop log file
#
# Prior to the command arguments, the caller can optionally provide "-a".  This will
# append to $LOG instead of overwriting.
log() {
  local args=$@
  if [ "-a" = $1 ]; then
    local append="-a"
    args=${@#-a}
  fi

  if [ 0 = $# ]; then
    less $LOG
  else
    $args 2>&1 | tee $append $LOG
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

# Lists the disk space used by members of the current directory in descending order
disk() {
  du -k * | sort -nr | cut -f2 | xargs -d '\n' du -sh
}

export IS_CYGWIN=false
if [ "$(uname -a | grep -i cygwin)" ]; then
  export IS_CYGWIN=true
fi

if $IS_CYGWIN; then
  . ~/mybash/cygwin.sh
fi
