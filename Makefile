targets = timelines tramscale walledcityscale timelines/misc experiments/oneoffs experiments/subplans

all: $(targets)

$(targets):
	$(MAKE) --directory=$@

rsync: all
	rsync -4Pav timelines experiments *scale --include 'preview.png' --include 'fantasy/*.png' --include 'experiments/*.png' --include 'experiments**/*.svg' --exclude '*.tiff' --exclude '*.png' --exclude '*.svg' --exclude '*azimuth*' arapp_arapp@ssh.nyc1.nearlyfreespeech.net:.

.PHONY: all $(targets) rsync
