all: pvd xmn lim ctu dxb she nap mty fnj bio tbs dlc ank osl rec tls cph izm sdj hel ams haj bru str tae fuk nue zrh sof kul waw buh lis pme jkt lyn bhz uio bog bak ccu osa hrk hfd cwl szd nkg ckg wuh del dus fra adl akl ath atl bcn ber bjs bne bom bos bue buf bwi cai can ccs chi cle clt dal den det dub gla hkg ind jax kbp las lax led lon lpl mad man mde mel mex mia mow msp muc ncl nyc orf par pdx per phl pit rio sac san sao scl sea sel sfo sha sin sju stl syd tpe vie was yeg ymq yow yto yvr yyc mnl prg thr pus ist ham rom msq bkk bhx wlg nqt mil slc tyo spk ngo bud maa sto tsn edi index.html anglo.html us.html

define WriteRules
ifeq ($(wildcard $(1)/cropscript.pl),$(1)/cropscript.pl)
$(1)/%.svg: $(1)/uncropped/%.svg $(1)/cropscript.pl
	if echo $$< | grep small >/dev/null; then true; else $(1)/cropscript.pl $$< > $$@ ; fi

$(1)/index.html: $(1)/name $(subst uncropped/,,$(patsubst %.svg,%.svg.gz,$(wildcard $(1)/uncropped/*.svg))) $(subst uncropped/,,$(wildcard $(1)/uncropped/*.svg)) ~/timelines/scripts/makeindex.sh $(wildcard ~/timelines/scripts/boilerplate/*)
	~/timelines/scripts/makeindex.sh $(1)

$(1): $(1)/uncropped $(1)/index.html $(subst uncropped/,,$(patsubst %.svg,%.svg.gz,$(wildcard $(1)/uncropped/*.svg))) $(subst uncropped/,,$(wildcard $(1)/uncropped/*.svg))

else
$(1)/small/%.svg: $(1)/%.svg
	mkdir -p small
	~/timelines/scripts/hideyear.pl $$< > $$@
	~/timelines/scripts/from-year-range.sh $(1)
	svgo --disable=cleanupNumericValues $$@

$(1)/index.html: $(wildcard $(1)/name $(1)/uncropped/name) $(patsubst %.svg,%.svg.gz,$(wildcard $(1)/*.svg)) ~/timelines/scripts/makeindex.sh $(wildcard ~/timelines/scripts/boilerplate/*)
	~/timelines/scripts/makeindex.sh $(1)

$(1): $(1)/index.html $(patsubst %.svg,%.svg.gz,$(wildcard $(1)/*.svg)) $(subst $(1),$(1)/small, $(wildcard $(1)/*.svg)) $(patsubst %.svg,%.svg.gz,$(subst $(1),$(1)/small, $(wildcard $(1)/*.svg)))

endif
endef

define WriteOverview
$(1): $(patsubst %,%/small/2015.svg,$(2)) ~/timelines/scripts/makeoverview.sh ; ~/timelines/scripts/makeoverview.sh $(2) | sed -e"s!UNTITLED!$(3)!; s!<a href=.$(1).>\(.*\)<.a>!\1!" > $(1)
endef

define WriteMainIndex
$(1): $(patsubst %,%/small/2015.svg,$(2)) $(wildcard ???/s) ~/timelines/scripts/makemainindex.sh ; ~/timelines/scripts/makemainindex.sh $(2) > $(1)
endef

%.svg.gz : %.svg
	gzip -f --keep $<

.PHONY: all $(wildcard ???) $(wildcard ???/small) $(wildcard ???/uncropped) $(wildcard ???/uncropped/small) rsync makeindex
.SECONDARY:
$(foreach dir, $(wildcard ??? ???/uncropped), $(eval $(call WriteRules, $(dir))))

rsync: all
	rsync -4Pav ~/timelines/timelines --exclude '*osm*.png' --exclude '*streetmap*' arapp_arapp@ssh.phx.nearlyfreespeech.net:.

$(call WriteOverview,us.html,nyc chi bwi bos pvd pit phl lax sfo cle sea was atl san mia buf pdx sac det jax dal stl den las slc ind msp clt sju orf hfd,United States)
$(call WriteOverview,anglo.html,lon mel lpl syd gla ncl yvr adl man pme yto per yeg bhx bne yyc yow dub cwl szd nqt edi akl,Non-US Anglosphere)
$(call WriteMainIndex,index.html,lon nyc par mel ber syd chi bud bos vie osl tyo dus osa phl lax ham cai yvr ngo bue fuk sfo mad bcn bom sto lis nap ath cph mow rio was bru yto rom led sao kbp ams waw mil tbs str ymq maa bak sdj muc fra mex spk nue hel bjs fnj prg sel hrk scl haj zrh lyn hkg buh bne ccs lil msq ccu mnl tsn rec pus bhz sin ist bkk mty sha tls bio mde tpe ank kul uio tae sof can thr izm bog dlc del lim jkt wuh ckg nkg xmn dxb ctu she)
