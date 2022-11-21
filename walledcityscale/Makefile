all: index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg)) rtoverlay

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: names makeindex.sh $(wildcard *0.svg)
	./makeindex.sh $(wildcard *.svg) > $@

rtoverlay:
	$(MAKE) --directory=$@

.PHONY: all rtoverlay
