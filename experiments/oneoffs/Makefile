all: large.html index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: names makeindex.sh $(wildcard *.svg) ~/timelines/scripts/boilerplate/part4
	./makeindex.sh 10 Past: mkc.svg sux.svg lou.svg roc.svg ind.svg Special-Purpose: dws.svg qca.svg mgw.svg > $@

large.html: names makeindex.sh $(wildcard *.svg) ~/timelines/scripts/boilerplate/part4
	./makeindex.sh 30 Past: mkc.svg sux.svg lou.svg roc.svg ind.svg Special-Purpose: dws.svg qca.svg mgw.svg > $@
