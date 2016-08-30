all: adl akl ath atl bcn ber bjs bne bom bos bue buf bwi cai can ccs chi cle clt dal den det dub gla hkg ind jax kbp las lax led lon lpl mad man mde mel mex mia mow msp muc ncl ngo nyc orf par pdx per phl pit rio sac san sao scl sea sel sfo sha sin sjc sju stl syd tpe vie was yeg ymq yow yto yvr yyc northamerica.html europe.html asia.html other.html canada.html australasia.html

define WriteSmall
year=$(strip $(2))
ifeq ($(wildcard $(1)/$(year).svg),)
$(1)/small/$(year).svg: $(1)/small/2015.svg
	~/timelines/scripts/blank.pl $(1)/small/2015.svg $(year) > $$@
	~/timelines/scripts/from-year-range.sh $(1)
else
$(1)/small/$(year).svg: $(1)/$(year).svg
	~/timelines/scripts/hideyear.pl $$< > $$@
	~/timelines/scripts/from-year-range.sh $(1)
endif
endef


define WriteRules
ifeq ($(wildcard $(1)/cropscript.pl),$(1)/cropscript.pl)
$(1)/%.svg: $(1)/uncropped/%.svg $(1)/cropscript.pl
	if echo $$< | grep small >/dev/null; then true; else $(1)/cropscript.pl $$< > $$@ ; fi

$(1)/index.html: $(1)/name $(1)/c $(subst uncropped/,,$(patsubst %.svg,%.svg.gz,$(wildcard $(1)/uncropped/*.svg))) $(subst uncropped/,,$(wildcard $(1)/uncropped/*.svg)) ~/timelines/scripts/makeindex.sh $(wildcard ~/timelines/scripts/boilerplate/*)
	~/timelines/scripts/makeindex.sh $(1)

$(1): $(1)/uncropped $(1)/index.html $(subst uncropped/,,$(patsubst %.svg,%.svg.gz,$(wildcard $(1)/uncropped/*.svg))) $(subst uncropped/,,$(wildcard $(1)/uncropped/*.svg))

else
$$(foreach yr, $(shell seq 1840 5 2015), $$(eval $$(call WriteSmall, $(1), $$(strip $$(yr)))))

$(1)/index.html: $(wildcard $(1)/name $(1)/uncropped/name $(1)/c $(1)/uncropped/c) $(patsubst %.svg,%.svg.gz,$(wildcard $(1)/*.svg)) ~/timelines/scripts/makeindex.sh $(wildcard ~/timelines/scripts/boilerplate/*)
	~/timelines/scripts/makeindex.sh $(1)

$(1): $(1)/small $(1)/index.html $(patsubst %.svg,%.svg.gz,$(wildcard $(1)/*.svg))

endif


$(1)/small: $(patsubst %,$(1)/small/%.svg.gz,$(shell seq 1840 5 2015))

endef

define WriteOverview
$(1): $(patsubst %,%/small/2015.svg,$(2)) ~/timelines/scripts/makeoverview.sh ; ~/timelines/scripts/makeoverview.sh $(2) | sed -e"s!UNTITLED!$(3)!; s!<a href=.$(1).>\(.*\)<.a>!\1!" > $(1)
endef

%.svg.gz : %.svg
	gzip -f --keep $<

.PHONY: all $(wildcard ???) $(wildcard ???/small) $(wildcard ???/uncropped) $(wildcard ???/uncropped/small) rsync makeindex
.SECONDARY:
$(foreach dir, $(wildcard ??? ???/uncropped), $(eval $(call WriteRules, $(dir))))

rsync: all
	rsync -Pav ~/timelines/timelines --exclude '*osm*.png' arapp_arapp@ssh.phx.nearlyfreespeech.net:.

$(call WriteOverview,northamerica.html,nyc chi bos phl lax sfo was yto ymq yvr,North American)
$(call WriteOverview,europe.html,lon par ber vie bcn mad mow led kbp muc,European)
$(call WriteOverview,asia.html,hkg bjs sel sin sha tpe can,East Asian)
$(call WriteOverview,other.html,mel syd cai bue bom rio sao mex scl ccs,Other)
$(call WriteOverview,canada.html,yto ymq yeg yyc yow yvr,Canadian)
$(call WriteOverview,australasia.html,mel syd adl bne per akl,Australia/NZ)
$(call WriteOverview,us.html,nyc chi bwi bos phl lax sfo cle sea was atl san mia pit buf pdx sac det sjc jax dal stl den las ind msp clt sju orf,United States)
