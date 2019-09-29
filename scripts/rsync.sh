#!/bin/bash

rsync -4Pav ~/timelines/timelines ~/timelines/experiments ~/timelines/streetcarscale ~/timelines/walledcityscale --exclude '*streetmap*' --exclude '*osm*.png' --exclude '*azimuth*' arapp_arapp@ssh.phx.nearlyfreespeech.net:.
