# cygwin-specific environment settings

export DT="$(cygpath -ua $USERPROFILE)/Desktop"
export DOWNLOADS="$(cygpath -ua $USERPROFILE)/Downloads"
export NPP="/cygdrive/c/Program Files (x86)/Notepad++/notepad++.exe"
export NPP_PY="$(cygpath -ua $APPDATA)/Notepad++/plugins/config/PythonScript/scripts"

# Export convenient variables for drives like C, D, etc
for drive in $(find /cygdrive -mindepth 1 -maxdepth 1 -type d)
do
  export $(echo ${drive##*/} | tr [:lower:] [:upper:])=$drive
done

# Open an Editor on the given file(s)
e() {
  "$NPP" "$@" &
}
