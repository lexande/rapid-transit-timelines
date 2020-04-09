all: large.html index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg)) preview.gif

%.svg.gz : %.svg
	svgo --disable=cleanupNumericValues $< -o - | gzip > $@

index.html: name cities ~/timelines/scripts/makerailindex.sh ~/timelines/scripts/template/part4 $(wildcard *.svg)
	~/timelines/scripts/makerailindex.sh . 1.5 > $@

large.html: name cities ~/timelines/scripts/makerailindex.sh ~/timelines/scripts/template/part4 $(wildcard *.svg)
	~/timelines/scripts/makerailindex.sh . 5 > $@

preview.gif: $(wildcard *.svg)
	~/timelines/scripts/previewgif.sh .

.SECONDARY:
