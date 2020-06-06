#!/usr/bin/env bash
# No More Masters

new_branch="release"

while getopts ":n:h" opt; do
  case ${opt} in
    n ) 
      new_branch=$OPTARG
      ;;
    h )
      echo "Usage:"
      echo "  no_masters.sh -n <new_branch_name>"
      echo "  defaults to \"release\""
      exit
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      exit
      ;;
    * )
      echo "Using defaults..."
      ;;
  esac
done

git checkout -b ${new_branch}
git branch -d master
git pull --ff-only origin ${new_branch}
git branch --set-upstream-to=origin/${new_branch}
