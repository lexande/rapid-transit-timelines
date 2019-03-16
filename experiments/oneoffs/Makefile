all: large.html index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh 10 Past: nyc.svg mci.svg sux.svg lou.svg roc.svg Special-Purpose: lon.svg dws.svg qca.svg mgw.svg ind.svg Future: hnl.svg > $@

large.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh 30 Past: nyc.svg mci.svg sux.svg lou.svg roc.svg Special-Purpose: lon.svg dws.svg qca.svg mgw.svg ind.svg Future: hnl.svg > $@
