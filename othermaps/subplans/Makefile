all: large.html index.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	~/timelines/scripts/round.py < $< > $<.tmp
	mv $<.tmp $<
	gzip -f --keep $<

NYC=nyc1935a.svg nyc1939plan.svg nyc1965a.svg nyc1968plan.svg nyc2025a.svg
CHI=chi1975a.svg chi1976plan.svg chi2025a.svg
BOS=bos1892plan.svg bos1915a.svg bos1917plan.svg bos1945a.svg bos1945plan.svg bos2025a.svg
PIT=pit1965a.svg pit1967plan.svg pit1970plan.svg pit2025a.svg
SFO=sfo1960a.svg sfo1961plan.svg sfo1966plan.svg sfo2025a.svg
SEA=sea1970plan.svg sea2000a.svg sea2002plan.svg sea2015a.svg sea2016plan.svg sea2025a.svg sea2026proj.svg
ZRH=zrh1973plan.svg ../../timelines/zrh/small/2024.svg
HNL=hnl2006plan.svg hnl2025a.svg
PVD=pvd1914.svg pvd1914plan.svg pvd2020.svg
CVG=cvg1920plan.svg
MSY=msy1959plan.svg
MAN=man1970a.svg man1971plan.svg man2024a.svg
CRL=crl2009plan.svg ../../timelines/crl/small/2024.svg
BER=../../timelines/ber/small/1955.svg ber1955plan.svg ber1989.svg ber1989west.svg ber1989east.svg ../../timelines/ber/small/1995.svg ber1996plan.svg ../../timelines/ber/small/2024.svg
YMQ=ymq1961plan.svg ymq1970a.svg ymq2015a.svg ymq2016plan.svg ymq2024a.svg

SVGS=$(NYC) $(BER) $(BOS) $(CHI) $(PIT) $(MAN) $(SFO) $(YMQ) $(SEA) $(ZRH) $(CRL) $(HNL) $(PVD) $(CVG) $(MSY)

RECROPPED=chi1975a.svg chi2025a.svg bos1915a.svg bos1945a.svg bos2025a.svg pit1965a.svg pit2025a.svg sfo2025a.svg sea2000a.svg sea2015a.svg hnl2025a.svg

nyc%a.svg : ../../timelines/nyc/small/%.svg Makefile
	sed -e's/6400/6850/; s/8200/6250/; s/ -1934 / 16 /; s/"-1727.04/"222.96/;' $< > $@

chi%a.svg : ../../timelines/chi/small/%.svg Makefile
	sed -e's/4300/3900/; s/6200/5650/' $< > $@

bos%a.svg : ../../timelines/bos/small/%.svg Makefile
	sed -e's/4450/5050/; s/ -775/ -1375/; s/"-568.04/"-1168.04/;' $< > $@

sfo%a.svg : ../../timelines/sfo/small/%.svg Makefile
	sed -e's/8950/7150/; s/12300/9250/; s/"35,/"-300,/; s/"124.45/"-210.55/;' $< > $@

hnl%a.svg : ../../timelines/hnl/small/%.svg Makefile
	sed -e's/1950/3250/; s/1200/2050/;' $< > $@

pit%a.svg : ../../timelines/pit/small/%.svg Makefile
	sed -e's/3650/4100/; s/2950/4350/; s/"-800, -100/"100, -1500/; s/106.96/-1293.04/; s/-710.55/189.45/' $< > $@

sea%a.svg : ../../timelines/sea/small/%.svg Makefile
	sed -e's/2050/4000/; s/5450/11550/; s/"50 -50 /"-670 -3915 /; s/"139.45/"-580.55/; s/"156.96/"-3708.04/;' $< > $@

ymq%a.svg : ../../timelines/ymq/small/%.svg Makefile
	sed -e's/2400/5500/; s/2550/2850/; s/"0 0/"-2100 -100/; s/"89.45/"-2010.55/; s/206.96/106.96/;' $< > $@

man%a.svg : ../../timelines/man/small/%.svg Makefile
	sed -e's/2650/3350/; s/4150/5700/; s/"-50 /"-750 /; s/"39.45/"-660.55/;' $< > $@


index.html: names makeindex.sh $(wildcard *.svg) $(SVGS) ~/timelines/scripts/template/part4 Makefile
	./makeindex.sh 10 $(NYC) $(BER) '<br>' $(BOS) $(CHI) $(PIT) $(MAN) '<br>' $(SFO) $(YMQ) $(SEA) $(ZRH) '<br>' $(CRL) $(HNL) $(PVD) $(CVG) $(MSY) > $@

large.html: names makeindex.sh $(wildcard *.svg) $(SVGS) ~/timelines/scripts/template/part4 Makefile
	./makeindex.sh 30 $(NYC) $(BER) $(BOS) $(CHI) $(PIT) $(MAN) $(SFO) $(YMQ) $(SEA) $(ZRH) $(CRL) $(HNL) $(PVD) $(CVG) $(MSY) > $@
