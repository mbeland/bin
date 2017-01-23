#!/bin/bash
# Automatically update environment repos
pathList=${1:-"$HOME/.repoList"} 
while read p; do
    case "$p" in \#*) continue ;; esac
    path=~/"$p"
    /usr/bin/git -C $path pull -q
done < $pathList

