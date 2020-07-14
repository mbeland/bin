#!/usr/bin/env bash
# No More Masters - Repo Edition

new_branch="release"
remote=
repo_path=
a_flag=0

while getopts ":r:d:n:h" opt; do
  case ${opt} in
    r )
      remote=$OPTARG
      ;;
    n ) 
      new_branch=$OPTARG
      ;;
    d )
      repo_path=$OPTARG
      a_flag=1
      ;;
    h )
      echo "Usage:"
      echo "  no_masters_repo.sh [-r <repo_location_ssh>] -d <path> [-n <new_branch_name>]"
      echo "    -r <repo_location_ssh> - <user>@<host>"
      echo "    REQUIRED: -d <path> - path of origin repo"
      echo "    -n <new_branch_name> - defaults to release"
      echo ""
      echo "Specify ssh connection string if required; path to origin repo required"
      exit
      ;;
    : )
      echo "Invalid option: $OPTARG requires an argument" 1>&2
      exit
      ;;
  esac
done

if [ $a_flag -eq 0 ] 
then
  echo "You must specify a repo location with -d; use -h for details"
  exit 2
fi

git checkout -b ${new_branch} master
git push -u origin ${new_branch}
git branch -d master
if [ -z $remote ] 
then
  cd ${repo_path} 
  git symbolic-ref HEAD refs/heads/${new_branch}
else 
  ssh ${remote} "cd ${repo_path} && git symbolic-ref HEAD refs/heads/${new_branch}"
fi
git push --delete origin master