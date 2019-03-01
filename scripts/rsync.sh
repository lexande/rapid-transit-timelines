#!/bin/bash

rsync -4Pav ~/timelines/timelines --exclude '*osm*.png' --exclude 'streetmap*' arapp_arapp@ssh.phx.nearlyfreespeech.net:.
rsync -4Pav ~/timelines/experiments/isochrones ~/timelines/experiments/walledcityscale ~/timelines/experiments/streetcarscale ~/timelines/experiments/oneoffs ~/timelines/experiments/subplans --exclude streetmap* --exclude '*osm*.png' arapp_arapp@ssh.phx.nearlyfreespeech.net:experiments/
