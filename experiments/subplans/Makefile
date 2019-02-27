all: large.html index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh 390 nyc1891.svg nyc1939.svg nyc1968.svg nyc2008.svg chi1976.svg bos1917.svg bos1945.svg sfo1966.svg msy1959.svg > $@

large.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh 1169 nyc1891.svg nyc1939.svg nyc1968.svg nyc2008.svg chi1976.svg bos1917.svg bos1945.svg sfo1966.svg msy1959.svg > $@
