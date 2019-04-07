all: roundof64.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

roundof64.html: makeindex.sh $(wildcard *.svg)
	./makeindex.sh Americas_Region: nyc.svg phl.svg yto.svg ymq.svg bue.svg was.svg scl.svg bos.svg mex.svg sfo.svg rio.svg chi.svg sao.svg mde.svg ccs.svg lim.svg EU/EFTA_Region: par.svg str.svg mil.svg ham.svg mad.svg bud.svg muc.svg sto.svg lon.svg zrh.svg vie.svg dus.svg ber.svg rom.svg bcn.svg prg.svg | sed -e's/NNN/64/' > $@
