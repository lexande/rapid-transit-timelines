all: large.html index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	~/timelines/scripts/round.py < $< > $<.tmp
	mv $<.tmp $<
	gzip -f --keep $<

NYC="../../timelines/nyc/uncropped/small/1935.svg nyc1939.svg ../../timelines/nyc/uncropped/small/1965.svg nyc1968.svg ../../timelines/nyc/uncropped/small/2020.svg"
CHI="achi1975.svg chi1976.svg achi2020.svg"
BOS="bos1892.svg abos1915.svg bos1917.svg abos1945.svg bos1945.svg abos2022.svg"
PIT="apit1965.svg pit1967.svg pit1970.svg apit2020.svg"
SFO="sfo1961.svg sfo1966.svg asfo2022.svg"
SEA="sea1970.svg asea2000.svg sea2002.svg asea2015.svg sea2016.svg fsea2026.svg"
ZRH="zrh1973.svg ../../timelines/zrh/small/2020.svg"
HNL="ahnl2023.svg fhnl2031.svg"
PVD="apvd1914.svg pvd1914.svg apvd2020.svg"
CVG="cvg1920.svg"
MSY="msy1959.svg"
MAN="aman1970.svg man1971.svg aman2020.svg"
CRL="crl2009.svg ../../timelines/crl/small/2020.svg"
BER="../../timelines/ber/small/1955.svg ber1955.svg aber1989.svg aberw1989.svg abere1989.svg ../../timelines/ber/small/1995.svg ber1996.svg ../../timelines/ber/small/2020.svg"
YMQ="ymq1961.svg aymq1970.svg aymq2020.svg fymq2027.svg"

index.html: names makeindex.sh $(wildcard *.svg) ~/timelines/scripts/template/part4 Makefile
	./makeindex.sh 10 $(NYC) $(BER) '<br>' $(BOS) $(CHI) $(PIT) $(PVD) $(MAN) '<br>' $(SFO) $(YMQ) $(SEA) $(ZRH) '<br>' $(CRL) $(HNL) $(CVG) $(MSY) > $@

large.html: names makeindex.sh $(wildcard *.svg) ~/timelines/scripts/template/part4 Makefile
	./makeindex.sh 30 $(NYC) $(BER) $(BOS) $(CHI) $(PIT) $(PVD) $(MAN) $(SFO) $(YMQ) $(SEA) $(ZRH) $(CRL) $(HNL) $(CVG) $(MSY) > $@
