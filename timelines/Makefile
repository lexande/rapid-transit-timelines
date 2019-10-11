all: $(wildcard ???) index.html

define WriteRules
ifeq ($(wildcard $(1)/cropscript.pl),$(1)/cropscript.pl)
$(1)/%.svg: $(1)/uncropped/%.svg $(1)/cropscript.pl
	if echo $$< | grep small >/dev/null; then true; else $(1)/cropscript.pl $$< > $$@ ; fi

$(1)/index.html: $(1)/name $(subst uncropped/,,$(patsubst %.svg,%.svg.gz,$(wildcard $(1)/uncropped/*.svg))) $(subst uncropped/,,$(wildcard $(1)/uncropped/*.svg)) ~/timelines/scripts/makeindex.sh $(wildcard ~/timelines/scripts/boilerplate/*)
	~/timelines/scripts/makeindex.sh $(1)

$(1): $(1)/uncropped $(1)/index.html $(subst uncropped/,,$(patsubst %.svg,%.svg.gz,$(wildcard $(1)/uncropped/*.svg))) $(subst uncropped/,,$(wildcard $(1)/uncropped/*.svg))

else
$(1)/small/%.svg: $(1)/%.svg
	mkdir -p $(1)/small
	~/timelines/scripts/hideyear.pl $$< > $$@
	~/timelines/scripts/from-year-range.sh $(1)
	svgo --disable=cleanupNumericValues $$@

$(1)/index.html: $(wildcard $(1)/name $(1)/uncropped/name) $(patsubst %.svg,%.svg.gz,$(wildcard $(1)/*.svg)) ~/timelines/scripts/makeindex.sh $(wildcard ~/timelines/scripts/boilerplate/*)
	~/timelines/scripts/makeindex.sh $(1)

$(1): $(1)/index.html $(patsubst %.svg,%.svg.gz,$(wildcard $(1)/*.svg)) $(subst $(1),$(1)/small, $(wildcard $(1)/*.svg)) $(patsubst %.svg,%.svg.gz,$(subst $(1),$(1)/small, $(wildcard $(1)/*.svg)))

endif
endef

%.svg.gz : %.svg
	gzip -f --keep $<

.PHONY: all $(wildcard ???) $(wildcard ???/small) $(wildcard ???/uncropped) $(wildcard ???/uncropped/small) rsync makeindex
.SECONDARY:
$(foreach dir, $(wildcard ??? ???/uncropped), $(eval $(call WriteRules, $(dir))))

rsync: all
	rsync -4Pav ~/timelines/timelines ~/timelines/experiments --exclude '*streetmap*' --exclude '*osm*.png' --exclude '*azimuth*' arapp_arapp@ssh.phx.nearlyfreespeech.net:.	

index.html: $(wildcard ???/small/2015.svg) $(wildcard ???/s) $(wildcard ???/name) ../scripts/makemainindex.sh ../scripts/boilerplate/part4 Makefile
	~/timelines/scripts/makemainindex.sh lon nyc par mel ber lpl syd chi gla bud bos vie osl tyo dus ncl pit osa phl lax ham cai tak koj yvr ngo bue fuk sfo mad cle hij toy bcn bom fsz sto lis myj adl ath man cph mow rio pme nap got bru yto per rom led fkb hfa kbp sea ams mil sof tbs str ymq maa bak sdj muc fra bfe mhg mex spk nue hel bjs fnj prg brn sel sao rlg hrk scl haj was crl zrh gdl tas mrs yeg lyn bhx lug atl hkg buh bne tun evn yyc qnc san ccs lil bwi yow mia msq dub ccu bsl vog mnl tsn poa rec buf pus goj ovb bhz pdx cwl kwg sac dtt sin kuf vlc ist jax dal goa bkk mty svx qls lej sha tls stl szd den waw ksf kul bio mde dnk tpe ank uio tae cta can slc thr izm bog bsb scn rns btz opo cgq dlc del lim oka jkt nqt kwj msp clt las wuh tlv drs edi sju ckg bfs nkg kzn vap trn cjj vln mar eml pmi tci alc peg akl khh czl xmn krk zda sdq ada svq ski dxb ayt bgo ctu she orf mhd xiy agp blr alg ala szv hgh vbs kmg hrb cgo pac csx ngb lpb ssa wux for syz hfd jai tbz add ifn tao khn > $@
