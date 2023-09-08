targets = timelines tramscale walledcityscale timelines/misc othermaps/oneoffs othermaps/subplans

all: $(targets)

$(targets):
	$(MAKE) --directory=$@

rsync: all
	rsync -4Pav timelines *scale othermaps --include 'preview.png' --include 'fantasy/*' --include 'experiments/*' --exclude '*.tiff' --exclude '*.png' --exclude '*.svg' --exclude '*azimuth*' arapp_arapp@ssh.nyc1.nearlyfreespeech.net:.

.PHONY: all $(targets) rsync
