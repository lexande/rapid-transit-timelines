all: index.html extra.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh atl.svg blk.svg clt.svg chc.svg cvg.svg dal.svg dtt.svg ool.svg hkg.svg hou.svg aly.svg jrs.svg mci.svg ccu.svg lit.svg mel.svg msy.svg par.svg phl.svg phx.svg pdx.svg slc.svg sfo.svg sea.svg tcm.svg yto.svg tus.svg was.svg > $@

extra.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh atl.svg blk.svg bos.svg cbg.svg clt.svg chc.svg cvg.svg dal.svg dtt.svg det.svg iom.svg ool.svg hkg.svg hou.svg aly.svg jrs.svg mci.svg ccu.svg lit.svg mel.svg mem.svg msy.svg nyc.svg par.svg phl.svg phx.svg pdx.svg slc.svg sfo.svg sea.svg tcm.svg tpa.svg yto.svg tus.svg vce.svg was.svg alo.svg > $@
