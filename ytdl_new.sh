#!/usr/bin/env bash
# Add a YouTube channel / user / playlist to the Plex system
/usr/local/bin/youtube-dl $1
echo "$1" >> ~/.config/youtube-dl/channel_list

