all: index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh athens-410.svg athens-400.svg rome-200.svg rome300.svg constantinople500.svg changan700.svg hangzhou1200.svg cairo1300.svg paris1400.svg beijing1500.svg tenochtitlan1500.svg beijing1800.svg > $@
