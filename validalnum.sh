#!/bin/bash
# validAlphaNum--Ensures that input consists only of alphabetical
#   and numeric characters.
# Minor adaptation from Wicked Cool Shell Scripts

fd=0 #stdin

validAlphaNum()
{
  # Validate arg: returns 0 if all upper+lower+digits, 1 otherwise.
  # Remove all unacceptable chars.
  validchars="$(echo $1 | sed -e 's/[^[:alnum:]]//g')"

  if [ "$validchars" = "$1" ] ; then
    return 0
  else
    return 1
  fi
}

# Interactive stub
if [[ -t "$fd" || -p /dev/stdin ]] ; then
	/bin/echo -n "Enter input:"
	read input

	#input validation
	if ! validAlphaNum "$input" ; then
		echo "Please enter only letters and numbers." >&2
		exit 1
	else
		echo "Input is valid."
	fi
fi
exit 0