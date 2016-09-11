#!/bin/bash
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for INFILE in $(find . -type f -name "*.mov"); 
do 
  OUTFILE=${INFILE//.mov/.mp4} 
  /usr/bin/avconv -i $INFILE -vcodec copy -strict experimental $OUTFILE
done
IFS=$SAVEIFS
