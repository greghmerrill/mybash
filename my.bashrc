shopt -s cdable_vars
export HISTSIZE=20000

log() { $@ 2>&1 | tee $DT/log.txt }

