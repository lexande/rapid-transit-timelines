#!/bin/bash

rsync -Pav ~/timelines/timelines --exclude streetmap* --exclude *osm.png arapp_arapp@ssh.phx.nearlyfreespeech.net:.
