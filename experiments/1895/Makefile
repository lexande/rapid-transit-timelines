all: large.html index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh 390 nyc.svg mci.svg lou.svg sux.svg chi.svg bwi.svg > $@

large.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh 1169 nyc.svg mci.svg lou.svg sux.svg chi.svg bwi.svg > $@
