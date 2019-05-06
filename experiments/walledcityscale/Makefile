all: index.html extra.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh babylon-500.svg athens-400.svg rome-200.svg alexandria-100.svg luoyang100.svg rome300.svg constantinople500.svg changan700.svg merv1100.svg cordoba1100.svg hangzhou1200.svg cairo1300.svg paris1400.svg beijing1500.svg tenochtitlan1500.svg venice1500.svg beijing1800.svg > $@

extra.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh babylon-500.svg athens-410.svg athens-400.svg rome-200.svg alexandria-100.svg jerusalem70.svg luoyang100.svg rome300.svg constantinople500.svg changan700.svg merv1100.svg cordoba1100.svg hangzhou1200.svg cairo1300.svg paris1400.svg beijing1500.svg tenochtitlan1500.svg venice1500.svg beijing1800.svg brc2015.svg > $@
