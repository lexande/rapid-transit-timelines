targets = timelines tramscale walledcityscale timelines/misc experiments/oneoffs experiments/subplans

all: $(targets)

$(targets):
	$(MAKE) --directory=$@

rsync: all
	rsync -4Pav ~/timelines/timelines ~/timelines/experiments ~/timelines/tramscale ~/timelines/walledcityscale --exclude '*streetmap*' --exclude '*osm*.png' --exclude '*azimuth*' arapp_arapp@ssh.phx.nearlyfreespeech.net:.

.PHONY: all $(targets) rsync
