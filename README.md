# risk_comp
Reduced Instruction Set toolKit for building and installing

## releasing

	version=$(sed -n 's/^VERSION:[ 	]*\([0-9.][0-9.]*\)[ 	]*$/\1/p' CID)
	rm -f risk_comp_$version.tar.gz
	git archive --prefix=risk_comp/ -o risk_comp_$version.tar.gz master
