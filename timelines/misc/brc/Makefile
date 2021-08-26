all: index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg)) preview.gif

%.svg.gz : %.svg
	perl -wpe'BEGIN { $$i=0; } if (/<image/) { $$i=1; } if ($$i) { if (/>/) { $$i=0; } s/.*\n//; }' $< | gzip > $@

preview.gif: $(wildcard *.svg)
	~/timelines/scripts/previewgif.sh .

index.html: makeindex.sh $(wildcard *.svg)
	./makeindex.sh > $@
