all: $(SVGS) index.html large.html

rsync: all
	rsync -4Pav *.png *.svg arapp_arapp@ssh.nyc1.nearlyfreespeech.net:fantasymaps/

SVGS=nyc-a.svg nyc.svg nycanachron.svg bos-a.svg bos.svg pit-a.svg pit.svg ../../was/small/2025.svg was.svg sfo-a.svg sfo.svg

nyc-a.svg : ../../nyc/small/2025.svg Makefile
	~/timelines/scripts/reviewbox.pl 0 0 250 0 $< > $@

pit-a.svg : ../../pit/small/2025.svg Makefile
	~/timelines/scripts/reviewbox.pl 950 0 0 0 $< > $@

bos-a.svg : ../../bos/small/2025.svg Makefile
	~/timelines/scripts/reviewbox.pl -400 -600 0 300 $< > $@

sfo-a.svg : ../../sfo/small/2025.svg Makefile
	~/timelines/scripts/reviewbox.pl -35 0 -1315 -5000 $< > $@

index.html: names ../subplans/makeindex.sh $(SVGS) ~/timelines/scripts/template/part4b Makefile
	$(foreach svg,$?,if echo $(svg) | grep "svg$$" >/dev/null; then ~/timelines/scripts/round.py $(svg) < $(svg) > $(svg).tmp && mv $(svg).tmp $(svg); fi;)
	../subplans/makeindex.sh 10 $(SVGS) | sed -e's/Unrealised Rapid Transit Plans/Rapid Transit Fantasy Maps/; s/Based on planned/Depicting/;'> $@

large.html: names ../subplans/makeindex.sh $(wildcard *.svg) ~/timelines/scripts/template/part4b Makefile
	../subplans/makeindex.sh 30 $(SVGS) | sed -e's/Unrealised Rapid Transit Plans/Rapid Transit Fantasy Maps/; s/Based on planned/Depicting/;'> $@

.PHONY: all rsync
