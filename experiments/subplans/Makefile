all: large.html index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

NYC="../../subtimeline/uncropped/small/1890.svg nyc1891.svg ../../subtimeline/uncropped/small/1935.svg nyc1939.svg ../../subtimeline/uncropped/small/1965.svg nyc1968.svg ../../subtimeline/uncropped/small/2020.svg"
CHI="achi1975.svg chi1976.svg achi2020.svg"
BOS="bos1892.svg abos1915.svg bos1917.svg abos1945.svg bos1945.svg abos2020.svg"
PIT="apit1965.svg pit1967.svg pit1970.svg apit2020.svg"
SFO="sfo1961.svg sfo1966.svg asfo2015.svg"
SEA="sea1970.svg asea2000.svg sea2002.svg asea2020.svg sea2024.svg sea2041.svg"
ZRH="zrh1973.svg ../../timelines/zrh/small/2020.svg"
HNL="hnl2025.svg"
PVD="pvd1914.svg"
CVG="cvg1920.svg"
HAV="hav1921.svg"
MSY="msy1959.svg"
MAN="aman1970.svg man1971.svg aman2020.svg"
CRL="crl2009.svg ../../timelines/crl/small/2020.svg"
BER="../../timelines/ber/small/1955.svg ber1955.svg aber1989.svg aberw1989.svg abere1989.svg ber1995.svg ../../timelines/ber/small/2020.svg"

index.html: names makeindex.sh $(wildcard *.svg) ~/timelines/scripts/template/part4 Makefile
	./makeindex.sh 10 $(NYC) $(BOS) $(PIT) $(CHI) '<br>' $(SFO) $(SEA) '<br>' $(BER) $(MAN) $(ZRH) $(CRL) '<br>' $(HNL) $(PVD) $(CVG) $(HAV) $(MSY) > $@

large.html: names makeindex.sh $(wildcard *.svg) ~/timelines/scripts/template/part4 Makefile
	./makeindex.sh 30 $(NYC) $(BOS) $(PIT) $(CHI) $(SFO) $(SEA) $(BER) $(MAN) $(ZRH) $(CRL) $(HNL) $(PVD) $(CVG) $(HAV) $(MSY) > $@
