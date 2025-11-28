all: index.html large.html

rsync: all
	rsync -4Pav *.png *.svg arapp_arapp@ssh.nyc1.nearlyfreespeech.net:fantasymaps/

SVGS=nyc2025a.svg nyc.svg nyc-anachron.svg bos2025a.svg bos.svg pit2025a.svg pit.svg ../../was/small/2025.svg was.svg sfo2025a.svg sfo.svg hkg1995a.svg hkg-nohandover.svg hkg2025a.svg

nyc%a.svg : ../../nyc/small/%.svg Makefile
	~/timelines/scripts/reviewbox.pl 0 0 250 0 $< > $@

pit%a.svg : ../../pit/small/%.svg Makefile
	~/timelines/scripts/reviewbox.pl 950 0 0 0 $< > $@

bos%a.svg : ../../bos/small/%.svg Makefile
	~/timelines/scripts/reviewbox.pl -400 -600 0 300 $< > $@

sfo%a.svg : ../../sfo/small/%.svg Makefile
	~/timelines/scripts/reviewbox.pl -35 0 -1315 -5000 $< > $@

hkg%a.svg : ../../hkg/small/%.svg Makefile
	~/timelines/scripts/reviewbox.pl 2800 4300 -1950 0 $< > $@

index.html: names ../subplans/makeindex.sh $(SVGS) ~/timelines/scripts/template/part4b Makefile
	$(foreach svg,$?,if echo $(svg) | grep "svg$$" >/dev/null; then ~/timelines/scripts/round.py $(svg) < $(svg) > $(svg).tmp && mv $(svg).tmp $(svg); fi;)
	../subplans/makeindex.sh 10 $(SVGS) | sed -e's/Unrealised Rapid Transit Plans/Rapid Transit Fantasy Maps/; s/Based on planned/Depicting/;'> $@

large.html: names ../subplans/makeindex.sh $(wildcard *.svg) ~/timelines/scripts/template/part4b Makefile
	../subplans/makeindex.sh 30 $(SVGS) | sed -e's/Unrealised Rapid Transit Plans/Rapid Transit Fantasy Maps/; s/Based on planned/Depicting/;'> $@

.PHONY: all rsync
