all: large.html index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg)) preview.gif

%.svg.gz : %.svg
	~/timelines/scripts/round.py < $< > $<.tmp
	mv $<.tmp $<
	gzip -f --keep $<

index.html: name cities ~/timelines/scripts/makerailindex.sh ~/timelines/scripts/template/part4 $(wildcard *.svg)
	~/timelines/scripts/makerailindex.sh . 2 > $@

large.html: name cities ~/timelines/scripts/makerailindex.sh ~/timelines/scripts/template/part4 $(wildcard *.svg)
	~/timelines/scripts/makerailindex.sh . 5 > $@

preview.gif: $(wildcard *.svg)
	~/timelines/scripts/previewgif.sh .

.PHONY: all
