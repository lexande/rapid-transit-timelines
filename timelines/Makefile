all: $(wildcard ???) index.html us.html uk.html

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

define WriteOverview
$(1): $(patsubst %,%/small/2015.svg,$(2)) ~/timelines/scripts/makeoverview.sh ~/timelines/scripts/boilerplate/part4; ~/timelines/scripts/makeoverview.sh $(2) | sed -e"s!UNTITLED!$(3)!; s!<a href=.$(1).>\(.*\)<.a>!\1!" > $(1)
endef

define WriteMainIndex
$(1): $(patsubst %,%/small/2015.svg,$(2)) $(wildcard ???/s) $(wildcard ???/name) ~/timelines/scripts/makemainindex.sh ~/timelines/scripts/boilerplate/part4; ~/timelines/scripts/makemainindex.sh $(2) > $(1)
endef

%.svg.gz : %.svg
	gzip -f --keep $<

.PHONY: all $(wildcard ???) $(wildcard ???/small) $(wildcard ???/uncropped) $(wildcard ???/uncropped/small) rsync makeindex
.SECONDARY:
$(foreach dir, $(wildcard ??? ???/uncropped), $(eval $(call WriteRules, $(dir))))

rsync: all
	rsync -4Pav ~/timelines/timelines ~/timelines/experiments --exclude '*streetmap*' --exclude '*osm*.png' --exclude '*azimuth*' arapp_arapp@ssh.phx.nearlyfreespeech.net:.	

$(call WriteOverview,us.html,nyc chi bos pit phl lax sfo cle sea was atl san bwi mia buf pdx sac dtt jax dal stl den slc msp clt las sju orf hfd,United States)
$(call WriteOverview,uk.html,lon lpl gla ncl man pme bhx cwl szd nqt edi bfs,United Kingdom)
$(call WriteMainIndex,index.html,lon nyc par mel ber lpl syd chi gla bud bos vie osl tyo dus ncl pit osa phl lax ham cai tak koj yvr ngo bue fuk sfo mad cle hij bcn bom fsz sto lis adl ath man cph mow rio nap got bru yto per rom led fkb kbp sea ams mil sof tbs str ymq maa bak sdj muc fra bfe mhg mex spk nue hel bjs fnj prg brn sel sao rlg hrk scl haj was zrh gdl tas mrs yeg lyn bhx atl hkg buh bne tun evn yyc san ccs lil bwi yow mia msq dub ccu vog mnl tsn poa rec pus goj ovb bhz pdx cwl kwg sac sin kuf vlc ist dal goa bkk mty svx qls lej sha tls stl szd den waw kul bio mde dnk tpe ank uio tae can slc thr izm bog bsb scn rns btz opo cgq dlc del lim oka jkt nqt kwj msp clt wuh tlv drs ckg bfs nkg kzn vap trn cjj vln mar tci alc akl khh czl xmn krk sdq ada svq dxb ayt bgo ctu she mhd xiy blr alg ala szv hgh vbs kmg hrb cgo pac csx ngb lpb ssa wux syz add ifn tao khn)
