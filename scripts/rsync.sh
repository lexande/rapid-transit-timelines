#!/bin/bash

rsync -4Pav ~/timelines/timelines --exclude '*osm*.png' arapp_arapp@ssh.phx.nearlyfreespeech.net:.
rsync -4Pav ~/timelines/isochrones --exclude '*osm*.png' arapp_arapp@ssh.phx.nearlyfreespeech.net:.
rsync -4Pav ~/timelines/experiments/nyc ~/timelines/experiments/streetcarscale ~/timelines/experiments/oneoffs --exclude streetmap* --exclude '*osm*.png' arapp_arapp@ssh.phx.nearlyfreespeech.net:experiments/
