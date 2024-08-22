all: index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg)) preview.gif

%.svg.gz : %.svg
	~/timelines/scripts/round.py < $< > $<.tmp
	mv $<.tmp $<
	perl -wpe's/\n/ /;' $< | perl -wpe's!data:image/[a-z]+;base64,[a-zA-Z0-9+/ ]+!!;' | gzip > $@

preview.gif: $(wildcard *.svg)
	~/timelines/scripts/previewgif.sh .

index.html: makeindex.sh $(wildcard *.svg)
	./makeindex.sh > $@

.PHONY: all
