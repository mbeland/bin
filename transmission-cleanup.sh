#!/bin/bash
#
# Cleanup transmission downloads after seeding to a ratio of 3
#
transmission-remote -l | grep 100% | grep Done | transmission-remote -t `awk '$8 > 3 {print $1}'` -r > /dev/null

