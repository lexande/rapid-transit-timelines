all: worst16.html roundof32.html roundof64.html $(patsubst %.svg,%.svg.gz,$(wildcard *.svg))

%.svg.gz : %.svg
	gzip -f --keep $<

roundof64.html: Makefile makeindex.sh $(wildcard *.svg) ~/timelines/scripts/template/part4
	./makeindex.sh Americas_Region: nyc.svg phl.svg yto.svg ymq.svg bue.svg was.svg scl.svg bos.svg mex.svg sfo.svg rio.svg chi.svg sao.svg mde.svg ccs.svg lim.svg Democratic_Europe_Region: par.svg zrh.svg vie.svg ham.svg mad.svg kbp.svg muc.svg sto.svg lon.svg rom.svg bcn.svg dus.svg ber.svg bud.svg mil.svg prg.svg Undemocratic_Afroeurasia_Region: bjs.svg xiy.svg sin.svg nkg.svg mow.svg wuh.svg hkg.svg thr.svg sha.svg ist.svg cai.svg ctu.svg can.svg ckg.svg szx.svg led.svg Democratic_Asia/Pacific_Region: tyo.svg ccu.svg mnl.svg maa.svg bom.svg spk.svg ngo.svg jkt.svg osa.svg mel.svg tpe.svg syd.svg sel.svg fuk.svg del.svg pus.svg | sed -e's/NNN/64/' > $@

roundof32.html: Makefile makeindex.sh $(wildcard *.svg) ~/timelines/scripts/template/part4
	./makeindex.sh Americas_Region: nyc.svg ymq.svg was.svg scl.svg mex.svg chi.svg sao.svg ccs.svg Democratic_Europe_Region: par.svg vie.svg mad.svg sto.svg lon.svg dus.svg ber.svg mil.svg Undemocratic_Afroeurasia_Region: bjs.svg sin.svg mow.svg hkg.svg sha.svg ctu.svg ckg.svg szx.svg Democratic_Asia/Pacific_Region: tyo.svg maa.svg spk.svg ngo.svg osa.svg tpe.svg sel.svg del.svg | sed -e's/NNN/32/' > $@

worst16.html: Makefile makeindex.sh $(wildcard *.svg) ~/timelines/scripts/template/part4
	./makeindex.sh Southeast_US_Region: jax.svg clt.svg orf.svg sju.svg Rest_of_US_Region: dtt.svg cle.svg buf.svg las.svg European_Union_Region: pmi.svg cta.svg peg.svg crl.svg Rest_of_World_Region: toy.svg for.svg edi.svg dnk.svg Quarterfinals: jax.svg orf.svg dtt.svg las.svg pmi.svg crl.svg for.svg edi.svg | sed -e's/Rapid Transit Bracket: Round of NNN/Worst Rapid Transit Bracket: Round of 16/' > $@
