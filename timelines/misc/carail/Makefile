all: large.html index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: name cities ~/timelines/scripts/makerailindex.sh $(wildcard *.svg)
	~/timelines/scripts/makerailindex.sh . 1.5 > $@

large.html: name cities ~/timelines/scripts/makerailindex.sh $(wildcard *.svg)
	~/timelines/scripts/makerailindex.sh . 5 > $@
