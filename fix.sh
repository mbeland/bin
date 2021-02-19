#!/bin/bash
x=0001
for file in *.mkv; do
    rename "s/S01EXXX/S01E$x/" "$file"
    x=$((x+1)) 
done
