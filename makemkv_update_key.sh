#!/bin/bash
# 
# Update MakeMKV Auth Key for Beta - 2016-10-29 by Matt Beland
#
# Depends on wget, sed, and html-xml-utils on Ubuntu
#
# Grab forum post with Beta key using wget, hxnormalize to parse it, hxselect to grab the div element "codecontent",
# then sed to strip the <div></div> tags from the returned text of the key. Finally, replace the existing settings
# file with an updated version using the new key.
#
# Runs from crontab.
#
key=`echo 'https://www.makemkv.com/forum2/viewtopic.php?f=5&t=1053' | wget -O- -i- -q | hxnormalize -x | hxselect -i "div.codecontent" | sed -e 's/<[^>]*>//g'`
cat >~/.MakeMKV/settings.conf <<EOL
#
# MakeMKV settings file, written by MakeMKV v1.10.2 linux(x64-release)
#

app_Key = "${key}"

EOL

