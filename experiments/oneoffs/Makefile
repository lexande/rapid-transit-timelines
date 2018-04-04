all: index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh cbg.svg dws.svg hnl.svg ind.svg lpb.svg lon.svg lou.svg mgw.svg mow.svg roc.svg sea.svg sux.svg > $@
