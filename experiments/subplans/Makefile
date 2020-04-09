all: large.html index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

NYC="../../subtimeline/small/1890.svg nyc1891.svg ../../subtimeline/small/1935.svg nyc1939.svg ../../subtimeline/small/1965.svg nyc1968.svg ../../subtimeline/small/2020.svg"
CHI="../../timelines/chi/small/1975.svg chi1976.svg ../../timelines/chi/small/2020.svg"
BOS="bos1892.svg ../../ttimeline/small/1915.svg  bos1917.svg ../../ttimeline/small/1945.svg bos1945.svg ../../ttimeline/small/2020.svg"
PIT="../../timelines/pit/small/1965.svg pit1969.svg ../../timelines/pit/small/2020.svg"
SFO="sfo1961.svg sfo1966.svg actualsfo2020.svg"
SEA="sea1970.svg actualsea2000.svg sea2002.svg actualsea2020.svg sea2024.svg sea2041.svg"
ZRH="zrh1973.svg ../../timelines/zrh/small/2020.svg"
HNL="hnl2020.svg hnl2025.svg"
PVD="pvd1914.svg"
CVG="cvg1920.svg"
HAV="hav1921.svg"
MSY="msy1959.svg"
MAN="actualman1970.svg man1971.svg actualman2020.svg"

index.html: names makeindex.sh $(wildcard *.svg) ~/timelines/scripts/boilerplate/part4 Makefile
	./makeindex.sh 10 $(NYC) $(BOS) $(PIT) $(CHI) '<br>' $(SFO) $(SEA) '<br>' $(MAN) $(ZRH) '<br>' $(HNL) $(PVD) $(CVG) $(HAV) $(MSY) > $@

large.html: names makeindex.sh $(wildcard *.svg) ~/timelines/scripts/boilerplate/part4 Makefile
	./makeindex.sh 30 $(NYC) $(BOS) $(PIT) $(CHI) $(SFO) $(SEA) $(MAN) $(ZRH) $(HNL) $(PVD) $(CVG) $(HAV) $(MSY) > $@
