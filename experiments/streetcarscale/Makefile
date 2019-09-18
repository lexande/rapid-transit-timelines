all: index.html extra.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: names makeindex.sh $(wildcard ???.svg) ~/timelines/scripts/boilerplate/part4
	./makeindex.sh $(wildcard ???.svg) > $@

extra.html: names makeindex.sh $(wildcard *.svg) ~/timelines/scripts/boilerplate/part4
	./makeindex.sh $(wildcard *.svg) > $@
