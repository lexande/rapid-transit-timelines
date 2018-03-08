all: index.html extra.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

index.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh atl.svg blk.svg clt.svg chc.svg cvg.svg dal.svg det.svg ool.svg hkg.svg hou.svg jrs.svg mci.svg lit.svg mel.svg msy.svg par.svg phl.svg phx.svg pdx.svg slc.svg sfo.svg sea.svg tcm.svg yto.svg tus.svg was.svg > $@

extra.html: names makeindex.sh $(wildcard *.svg)
	./makeindex.sh atl.svg blk.svg bos.svg clt.svg chc.svg cvg.svg dal.svg det.svg ool.svg hkg.svg hou.svg jrs.svg mci.svg lit.svg mel.svg msy.svg nyc.svg par.svg phl.svg phx.svg pdx.svg slc.svg sfo.svg sea.svg tcm.svg yto.svg tus.svg vce.svg was.svg alo.svg > $@
