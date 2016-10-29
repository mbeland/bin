#!/bin/bash
key=`echo 'https://www.makemkv.com/forum2/viewtopic.php?f=5&t=1053' | wget -O- -i- -q | hxnormalize -x | hxselect -i "div.codecontent" | sed -e 's/<[^>]*>//g'`
cat >~/.MakeMKV/settings.conf <<EOL
#
# MakeMKV settings file, written by MakeMKV v1.10.2 linux(x64-release)
#

app_Key = "${key}"

EOL

