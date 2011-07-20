export HISTSIZE=20000
export CYGWIN=nodosfilewarning
export C=/cygdrive/c
export PS1='\[\e]0;\w\a\]\n\[\e[32m\]*\h* \[\e[33m\]\w\[\e[0m\]\n\$ '

shopt -s cdable_vars

alias ll='ls -l'

log() { 
  $@ 2>&1 | tee $DT/log.txt 
}

start() {
  cmd /c start "$@"
}

dt() {
	cd $DT
}

