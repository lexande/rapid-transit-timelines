#!/bin/bash

rsync -Pav ~/timelines/timelines --exclude streetmap* arapp_arapp@ssh.phx.nearlyfreespeech.net:.
