all: large.html index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	~/timelines/scripts/round.py < $< > $<.tmp
	mv $<.tmp $<
	gzip -f --keep $<

maps = Past: mkc.svg lou.svg sux.svg roc.svg ct_.svg vcp.svg hl_.svg nbc.svg ind.svg Special-Purpose: dws.svg qca.svg mgw.svg

index.html: names makeindex.sh $(wildcard *.svg) ~/timelines/scripts/template/part4 Makefile
	./makeindex.sh 10 $(maps) > $@

large.html: names makeindex.sh $(wildcard *.svg) ~/timelines/scripts/template/part4 Makefile
	./makeindex.sh 30 $(maps) > $@
