#!/bin/bash

rsync -Pav ~/timelines/timelines --exclude '*osm*.png' arapp_arapp@ssh.phx.nearlyfreespeech.net:.
rsync -Pav ~/timelines/isochrones --exclude '*osm*.png' arapp_arapp@ssh.phx.nearlyfreespeech.net:.
rsync -Pav ~/timelines/experiments/nyc ~/timelines/experiments/streetcarscale --exclude streetmap* --exclude '*osm*.png' arapp_arapp@ssh.phx.nearlyfreespeech.net:experiments/
