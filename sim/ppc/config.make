#! /bin/sh

# Helper script to turn --enable-sim-xxx switches into make variables

# Arg 1 -- header name
# Arg 2 -- define name
# Arg 3 -- --enable-sim switch spelling
# Arg 4 -- --enable-sim switch value
# the remaining switches are paired, with the first being the value to test arg 4 against
# and the second is the value to put in the define if it matches

make="$1"
shift

makevar="$1"
shift

switch="$1"
shift

value="$1"
shift

while test $# -gt 1; do
	test_value="$1"
	shift

	set_value="$1"
	shift

	if test x"$value" = x"$test_value" -o x"$test_value" = x"*"; then
		echo "Setting $makevar=$set_value"
		(echo "";
		 if test x"$value" = x""; then
			 echo "# no $switch";
		 elif test x"$value" = x"yes"; then
			 echo "# $switch";
		 else
			 echo "# $switch=$value";
		 fi
		 if test x"$set_value" = x""; then
			 echo "$makevar ="
		 else
			 echo "$makevar = $set_value"
		 fi) >> $make
		exit 0;
	fi
done

if test x"$value" != x"" -a x"$value" != x"no"; then
	echo "$switch=$value is not supported" 1>&2
	exit 1
fi
