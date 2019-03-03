all: large.html index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh 390 ../../subtimeline/small/1890.svg nyc1891.svg ../../subtimeline/small/1935.svg nyc1939.svg ../../subtimeline/small/1965.svg nyc1968.svg ../../subtimeline/small/2020.svg ../../timelines/chi/small/1975.svg chi1976.svg ../../timelines/chi/small/2020.svg bos1892.svg ../../ttimeline/small/1915.svg  bos1917.svg ../../ttimeline/small/1945.svg bos1945.svg ../../ttimeline/small/2020.svg actualsfo1965.svg sfo1966.svg actualsfo2015.svg sea1970.svg actualsea2000.svg sea2002.svg actualsea2020.svg sea2024.svg sea2041.svg cvg1920.svg msy1959.svg > $@

large.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh 1169 ../../subtimeline/small/1890.svg nyc1891.svg ../../subtimeline/small/1935.svg nyc1939.svg ../../subtimeline/small/1965.svg nyc1968.svg ../../subtimeline/small/2020.svg ../../timelines/chi/small/1975.svg chi1976.svg ../../timelines/chi/small/2020.svg bos1892.svg ../../ttimeline/small/1915.svg  bos1917.svg ../../ttimeline/small/1945.svg bos1945.svg ../../ttimeline/small/2020.svg actualsfo1965.svg sfo1966.svg actualsfo2015.svg sea1970.svg actualsea2000.svg sea2002.svg actualsea2020.svg sea2024.svg sea2041.svg cvg1920.svg msy1959.svg > $@
