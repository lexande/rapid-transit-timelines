all: index.html extra.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: names makeindex.sh $(wildcard *.svg) ~/timelines/scripts/boilerplate/part4
	./makeindex.sh adl.svg alg.svg ams.svg atl.svg ber.svg blk.svg bud.svg bue.svg cbr.svg clt.svg chc.svg cvg.svg dal.svg den.svg dtt.svg elp.svg ool.svg hel.svg hij.svg hkg.svg hou.svg aly.svg jrs.svg mci.svg khh.svg ccu.svg kbp.svg lis.svg lit.svg mde.svg mel.svg mem.svg mke.svg ntl.svg msy.svg okc.svg osl.svg par.svg phl.svg phx.svg pdx.svg prg.svg fnj.svg rio.svg rtm.svg slc.svg sfo.svg led.svg ssz.svg sea.svg sto.svg tcm.svg tpa.svg yto.svg tus.svg vce.svg was.svg vie.svg > $@

extra.html: names makeindex.sh $(wildcard *.svg) ~/timelines/scripts/boilerplate/part4
	./makeindex.sh adl.svg alg.svg ams.svg atl.svg ber.svg blk.svg bud.svg bue.svg cbg.svg cbr.svg clt.svg chc.svg cvg.svg dal.svg den.svg dtt.svg elp.svg ool.svg hel.svg hij.svg hkg.svg hou.svg aly.svg jrs.svg mci.svg khh.svg ccu.svg kbp.svg lis.svg lit.svg mde.svg mel.svg mem.svg mke.svg ntl.svg msy.svg nyc.svg okc.svg osl.svg par.svg phl.svg phx.svg pdx.svg prg.svg fnj.svg rio.svg rtm.svg slc.svg sfo.svg led.svg ssz.svg sea.svg sto.svg tcm.svg tpa.svg yto.svg tus.svg vce.svg was.svg alo.svg vie.svg > $@
