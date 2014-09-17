#!/bin/bash
~/timelines/scripts/autopng.sh *.svg && 
~/timelines/scripts/makesmall.sh *.svg &&
~/timelines/scripts/rsync.sh
