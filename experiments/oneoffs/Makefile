all: large.html index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh 390 cbg.svg dws.svg hnl.svg ind.svg lpb.svg lon.svg lou.svg mgw.svg roc.svg sea.svg sux.svg > $@

large.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh 1169 cbg.svg dws.svg hnl.svg ind.svg lpb.svg lon.svg lou.svg mgw.svg roc.svg sea.svg sux.svg > $@
