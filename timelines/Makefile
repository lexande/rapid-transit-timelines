all: $(wildcard ???) index.html

define WriteRules
ifeq ($(wildcard $(1)/cropscript.pl),$(1)/cropscript.pl)
$(1)/small/%.svg: ;
$(1)/%.svg:: $(1)/uncropped/%.svg $(1)/cropscript.pl
	$(1)/cropscript.pl $$< > $$@

$(1)/index.html: $(1)/name $(subst uncropped/,,$(patsubst %.svg,%.svg.gz,$(wildcard $(1)/uncropped/*.svg)) $(wildcard $(1)/uncropped/*.svg)) ~/timelines/scripts/makeindex.sh $(wildcard ~/timelines/scripts/boilerplate/*) $(wildcard $(1)/seealso)
	~/timelines/scripts/makeindex.sh $(1)

$(1)/animated.gif: $(wildcard $(1)/*.svg) ~/timelines/scripts/anim-notext.sh
	~/timelines/scripts/anim-notext.sh $(1)


$(1): $(1)/uncropped $(1)/index.html $(subst uncropped/,,$(patsubst %.svg,%.svg.gz,$(wildcard $(1)/uncropped/*.svg)) $(wildcard $(1)/uncropped/*.svg))

else
$(1)/small/%.svg: $(1)/%.svg
	mkdir -p $(1)/small
	~/timelines/scripts/hideyear.pl $$< > $$@
	~/timelines/scripts/from-year-range.sh $(1)
	svgo --disable=cleanupNumericValues $$@

$(1)/animated.gif: $(wildcard $(1)/*.svg) ~/timelines/scripts/anim-notext.sh
	~/timelines/scripts/anim-notext.sh $(1)

$(1)/index.html: $(wildcard $(1)/name $(1)/../name $(1)/seealso $(1)/../seealso) $(patsubst %.svg,%.svg.gz,$(wildcard $(1)/*.svg)) ~/timelines/scripts/makeindex.sh $(wildcard ~/timelines/scripts/boilerplate/*)
	~/timelines/scripts/makeindex.sh $(1)

$(1): $(1)/index.html $(patsubst %.svg,%.svg.gz,$(wildcard $(1)/*.svg)) $(subst $(1),$(1)/small, $(wildcard $(1)/*.svg) $(patsubst %.svg,%.svg.gz,$(wildcard $(1)/*.svg)))

endif
endef

%.svg.gz : %.svg
	gzip -f --keep $<

.PHONY: all $(wildcard ???) $(wildcard ???/small) $(wildcard ???/uncropped) $(wildcard ???/uncropped/small)
.SECONDARY:
$(foreach dir, $(wildcard ??? ???/uncropped), $(eval $(call WriteRules, $(dir))))

index.html: $(wildcard ???/small/2020.svg) $(wildcard ???/s) $(wildcard ???/name) ../scripts/makemainindex.sh ../scripts/boilerplate/part4 opening-dates
	~/timelines/scripts/makemainindex.sh `awk -F'\t' '{print $$2}' opening-dates` > $@
