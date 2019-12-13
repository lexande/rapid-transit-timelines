targets = timelines streetcarscale walledcityscale timelines/misc experiments/alonbracket experiments/oneoffs experiments/subplans experiments/mashup

all: $(targets)

$(targets):
	$(MAKE) --directory=$@

rsync: all
	rsync -4Pav ~/timelines/timelines ~/timelines/experiments ~/timelines/streetcarscale ~/timelines/walledcityscale --exclude '*streetmap*' --exclude '*osm*.png' --exclude '*azimuth*' arapp_arapp@ssh.phx.nearlyfreespeech.net:.

.PHONY: all $(targets) rsync
.SECONDARY:
