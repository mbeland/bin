#!/bin/bash
git clone matt@odin.rearviewmirror.org:repos/ssh
git clone matt@odin.rearviewmirror.org:repos/skel
cd ssh/
./initiate.sh
cd ~/skel/
rm -rf ~/.git*
rm -f ~/.bashrc
rm -f ~/.vimrc
rm -rf ~/.irssi
mv .bashrc ~/
mv .vimrc ~/
mv .irssi ~/
mv .git* ~/
mv .repoList ~/
cd ~
rmdir skel/

