all: $(wildcard ???) index.html

define WriteRules
ifeq ($(wildcard $(1)/cropscript.pl),$(1)/cropscript.pl)
$(1)/small/%.svg: ;
$(1)/%.svg:: $(1)/uncropped/%.svg $(1)/cropscript.pl
	$(1)/cropscript.pl $$< > $$@

$(1)/index.html: $(1)/name $(subst uncropped/,,$(patsubst %.svg,%.svg.gz,$(wildcard $(1)/uncropped/*.svg))) $(subst uncropped/,,$(wildcard $(1)/uncropped/*.svg)) ~/timelines/scripts/makeindex.sh $(wildcard ~/timelines/scripts/boilerplate/*) $(wildcard $(1)/seealso)
	~/timelines/scripts/makeindex.sh $(1)

$(1): $(1)/uncropped $(1)/index.html $(subst uncropped/,,$(patsubst %.svg,%.svg.gz,$(wildcard $(1)/uncropped/*.svg))) $(subst uncropped/,,$(wildcard $(1)/uncropped/*.svg))

else
$(1)/small/%.svg: $(1)/%.svg
	mkdir -p $(1)/small
	~/timelines/scripts/hideyear.pl $$< > $$@
	~/timelines/scripts/from-year-range.sh $(1)
	svgo --disable=cleanupNumericValues $$@

$(1)/index.html: $(wildcard $(1)/name $(1)/../name) $(patsubst %.svg,%.svg.gz,$(wildcard $(1)/*.svg)) ~/timelines/scripts/makeindex.sh $(wildcard ~/timelines/scripts/boilerplate/*) $(wildcard $(1)/seealso $(1)/../seealso)
	~/timelines/scripts/makeindex.sh $(1)

$(1): $(1)/index.html $(patsubst %.svg,%.svg.gz,$(wildcard $(1)/*.svg)) $(subst $(1),$(1)/small, $(wildcard $(1)/*.svg)) $(patsubst %.svg,%.svg.gz,$(subst $(1),$(1)/small, $(wildcard $(1)/*.svg)))

endif
endef

%.svg.gz : %.svg
	gzip -f --keep $<

.PHONY: all $(wildcard ???) $(wildcard ???/small) $(wildcard ???/uncropped) $(wildcard ???/uncropped/small)
.SECONDARY:
$(foreach dir, $(wildcard ??? ???/uncropped), $(eval $(call WriteRules, $(dir))))

index.html: $(wildcard ???/small/2020.svg) $(wildcard ???/s) $(wildcard ???/name) ../scripts/makemainindex.sh ../scripts/boilerplate/part4 Makefile
	~/timelines/scripts/makemainindex.sh lon nyc par mel ber lpl syd chi gla bud bos vie osl tyo dus ncl pit osa phl lax ham cai tak koj yvr ngo bue fuk sfo mad cle hij toy bcn bom fsz sto lis myj adl ath man cph mow rio pme nap bru yto per rom got led fkb kbp ams mil sof tbs ymq maa bre bak sdj muc fra bfe mhg mex spk nue str hel bjs fnj prg brn sel sao rlg hrk scl haj was crl zrh gdl tas mrs yeg lyn bhx lug atl hkg buh bne tun evn yyc qnc san ccs lil bwi yow mia msq dub ccu bsl vog mnl tsn poa rec buf pus goj ovb bhz pdx cwl kwg sac dtt sin kuf vlc ist dal goa sea bkk mty svx qls lej kya sha tls stl szd den sxb uro waw ksf kul bio mde dnk tpe ank uio tae jax cta can slc thr izm bog bsb scn rns btz opo cgq dlc del lim oka jkt nqt kwj msp clt las wuh lnz tlv drs sju ckg bfs nkg kzn vap trn cjj vln mar eml gua pmi tci alc peg akl khh xmn krk zda qar sdq ada svq ski jnb dxb grq ayt bgo ctu she szf mlh orf mhd xiy agp blr alg ala ywg szv hgh lhe vbs kmg ifn czl hrb cgo pac csx ngb lpb edi ssa wux for syz hfd jai isb pcx tbz add tao khn bod wlg gva mdz ykf nce > $@
