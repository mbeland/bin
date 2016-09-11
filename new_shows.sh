#!/bin/bash
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
for OUTPUT in $(find /mnt/media/TV\ Shows/ -type d -name tempfiles -prune -o -cmin -1440 -type f -printf "%f\n"); 
do 
  echo ${OUTPUT:0:-4}
done
IFS=$SAVEIFS

