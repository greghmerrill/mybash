export PS1='\[\e]0;\w\a\]\n\[\e[32m\]*\h $(date +%H:%M:%S)* \[\e[33m\]\w\[\e[0m\]\n\$ '
export HISTSIZE=20000
export PATH=".:$PATH"

export LOG=~/.log.txt

shopt -s cdable_vars

alias ll='ls -lh'
alias sql='rlwrap -b "" -f ~/.sql.dict sqlplus'
alias sshconf='cd ~ && e .ssh/config && cd -'
alias sshkh='cd ~ && e .ssh/known_hosts && cd -'
alias bashrc='cd ~ && e .bashrc && cd -'

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

sshwin() {
	title $*
	bash -c "$realssh $@"
}

# Lists the disk space used by members of the current directory in descending order
disk ()
{
    lines=${1:-20};
    echo Finding top $lines consumers of disk space in current dir \(provide additional argument to disk change limit\):;
    du -h -d 0 -h -k $(find . -mindepth 1 -maxdepth 1 -name "*") 2> /dev/null | sort -nr | cut -f2 | xargs -d '\n' du -sh 2> /dev/null | head -n $lines
}

export IS_CYGWIN=false
if [ "$(uname -a | grep -i cygwin)" ]; then
  export IS_CYGWIN=true
fi

if $IS_CYGWIN; then
  . ~/mybash/cygwin.sh
fi

patch() {
  rsync --chmod=a+rwx $1 $2:$3
  ssh $2 ls -l $(dirname $3)
}

_ssh() 
{
    local cur prev opts
    COMPREPLY=()
    cur="${COMP_WORDS[COMP_CWORD]}"
    prev="${COMP_WORDS[COMP_CWORD-1]}"
    opts=$(grep '^Host' ~/.ssh/config | grep -v '[?*]' | cut -d ' ' -f 2-)

    COMPREPLY=( $(compgen -W "$opts" -- ${cur}) )
    return 0
}
complete -F _ssh ssh

gdc () {
  git diff $1~ $1
}
