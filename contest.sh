#!/bin/bash
#
# Contest winner script
wholist=(
		Last,First,6
	)

# Build entry list

declare -a ENTRIES

entry=0
for name in "${wholist[@]}"
do
	IFS=',' read -r -a line <<< "$name"
	while [ ${line[2]} -gt 0 ]
	do
		ENTRIES[entry]="${line[1]} ${line[0]}"
		entry=$(( $entry + 1 ))
		line[2]=$(( ${line[2]} - 1 ))
	done
done

range=$(( $entry - 1 ))
echo "And the winner is... ${ENTRIES[$(shuf -i 1-$range -n 1)]}"


