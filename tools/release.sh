#!/bin/sh
# Thierry Laronde <tlaronde@kergis.com>
#

# It has to be run at the root of our sources.
#
test -s CID \
	|| { echo "You must run me from RISK_COMP root dir!" >&2; exit 1; }

version=$(sed -n 's/^VERSION:[ 	]*\([0-9.][0-9.]*\)[ 	]*$/\1/p' CID)

rm -f risk_comp_$version.tar.gz

git archive --prefix=risk_comp/ -o risk_comp_$version.tar master

gzip risk_comp_$version.tar

