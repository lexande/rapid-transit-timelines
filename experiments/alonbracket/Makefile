all: roundof64.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

roundof64.html: makeindex.sh $(wildcard *.svg) ~/timelines/scripts/boilerplate/part4
	./makeindex.sh Americas_Region: nyc.svg phl.svg yto.svg ymq.svg bue.svg was.svg scl.svg bos.svg mex.svg sfo.svg rio.svg chi.svg sao.svg mde.svg ccs.svg lim.svg Democratic_Europe_Region: par.svg zrh.svg vie.svg ham.svg mad.svg kbp.svg muc.svg sto.svg lon.svg rom.svg bcn.svg dus.svg ber.svg bud.svg mil.svg prg.svg Undemocratic_Afroeurasia_Region: bjs.svg xiy.svg sin.svg nkg.svg mow.svg wuh.svg hkg.svg thr.svg sha.svg ist.svg cai.svg ctu.svg can.svg ckg.svg hkg.svg led.svg Democratic_Asia/Pacific_Region: tyo.svg ccu.svg mnl.svg bkk.svg bom.svg spk.svg ngo.svg jkt.svg osa.svg mel.svg tpe.svg syd.svg sel.svg fuk.svg del.svg pus.svg | sed -e's/NNN/64/' > $@
