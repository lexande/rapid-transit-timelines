all: index.html extra.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: names makeindex.sh $(wildcard *0.svg)
	./makeindex.sh $(wildcard *0.svg) > $@

extra.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh $(wildcard *.svg) > $@
