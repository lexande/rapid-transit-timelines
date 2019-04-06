all: roundof64.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

roundof64.html: makeindex.sh $(wildcard *.svg)
	./makeindex.sh nyc.svg phl.svg yto.svg ymq.svg bue.svg was.svg scl.svg bos.svg mex.svg sfo.svg rio.svg chi.svg sao.svg mde.svg ccs.svg lim.svg | sed -e's/NNN/64/' > $@
