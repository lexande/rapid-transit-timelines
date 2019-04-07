#!/bin/bash

rsync -4Pav ~/timelines/timelines ~/timelines/experiments --exclude '*streetmap*' --exclude '*osm*.png' --exclude '*azimuth*' arapp_arapp@ssh.phx.nearlyfreespeech.net:.
