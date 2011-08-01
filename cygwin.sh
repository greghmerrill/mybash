# cygwin-specific environment settings

export DT="$(cygpath -ua $USERPROFILE)/Desktop"

# Export convenient variables for drives like C, D, etc
for drive in $(find /cygdrive -mindepth 1 -maxdepth 1 -type d)
do
	export $(echo ${drive##*/} | tr [:lower:] [:upper:])=$drive
done

# Open an Editor on the given file(s)
e() {
  'C:/Program Files (x86)/Notepad++/notepad++.exe' "$@" &
}
