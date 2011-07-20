shopt -s cdable_vars
export HISTSIZE=20000

alias ll='ls -l'

log() { 
  $@ 2>&1 | tee $DT/log.txt 
}

start() {
  cmd /c start "$@"
}

