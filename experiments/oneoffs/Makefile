all: large.html index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

maps = Past: mkc.svg sux.svg lou.svg roc.svg ind.svg Special-Purpose: dws.svg qca.svg mgw.svg Other: canhkg.svg ../alonbracket/nyc.svg

index.html: names makeindex.sh $(wildcard *.svg) ~/timelines/scripts/template/part4 Makefile
	./makeindex.sh 10 $(maps) > $@

large.html: names makeindex.sh $(wildcard *.svg) ~/timelines/scripts/template/part4 Makefile
	./makeindex.sh 30 $(maps) > $@
