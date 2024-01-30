#!/bin/sh
#
# C) 2012 Thierry Laronde <tlaronde@polynum.com>
#
# Update from earlier version to 1.11 map format.
#

usage="
update1_1.sh PROJECT.map

  will backup old map to PROJECT.map.bak and create new one with new
  fields order.
"

test $# -eq 1 || { echo "$usage" >&2 ; exit 1; }

test -f $1 || { echo "$1 doesn't exist!" >&2; exit 2; }
test ! -f $1.bak || { echo "$1.bak already exists. Remove first if OK!" >&2; exit 3; }

mv $1 $1.bak

# Don't cat /dev/null, just touch. This should create since not existing
# but, if something went wrong (or writer of the script forgot 
# something...) this will add and not destroy...
#
tmpfile=${TMPDIR:-/tmp}/$$
cat /dev/null >$tmpfile
while read action type src dst owner mod; do
	if test "x$action" = x; then # empty line
    echo >>$tmpfile
  elif expr "$action" : "#" >/dev/null 2>&1; then
    echo "$action $type $src $dst $owner $mod" >>$tmpfile
  else
    # Will work for empty lines too.
    translated=$(echo "$dst"|sed -e 's!TARGETMANDIR$!TARGETOPTDIR/0!'\
      -e 's!TARGETMANDIR/!TARGETOPTDIR!' -e 's!man/man\([1-9]\)!\1!'\
      -e 's!man/\([1-9]\)!\1!' -e 's!\$TARGETMAN[A-Z]*SFX!!')
    if test "$translated" != "$dst"; then
      case $type in
        d) ftn=Tmandir;;
        f) ftn=Tman;;
        *) ftn=;;
      esac
      echo "$action $type $owner $mod $src $translated $ftn" >>$tmpfile
    else
      echo "$action $type $owner $mod $src $dst" >>$tmpfile
    fi
  fi
done <$1.bak

# Remove added trailing spaces caused by echoinng inexisting fields.
#
sed -e 's/ *$//' -e 's/  */ /g' $tmpfile >$1
exit 0
