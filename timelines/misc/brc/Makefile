all: index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	perl -wpe'BEGIN { $$i=0; } if (/<image/) { $$i=1; } if ($$i) { if (/>/) { $$i=0; } s/.*\n//; }' $< | gzip > $@

index.html: makeindex.sh $(wildcard *.svg)
	./makeindex.sh > $@
