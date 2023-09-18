all: hsr bymode regrail sandy nyctrolleys nycflights ivytunnels 88nv

bymode = nycbymode bosbymode sfobymode berbymode alobymode cbgbymode
bymode: $(bymode)

regrail = nerail carail gbrail
regrail: $(regrail)

define bymoderule
$(1): $(patsubst %.svg,%.svg.gz,$(wildcard $(1)/*.svg)) $(1)/preview.gif $(1)/index.html

$(1)/index.html: $(1)/name $(1)/seealso $(1)/preview.gif  $(1)/preview.gif $(wildcard $(1)/*.svg) ~/timelines/scripts/makeindex.sh $(wildcard ~/timelines/scripts/template/*)
	~/timelines/scripts/makeindex.sh $(1) > $$@
endef

$(foreach dir, $(bymode), $(eval $(call bymoderule, $(dir))))

hsr: $(patsubst %.svg,%.svg.gz,$(wildcard hsr/?/*.svg))

ivytunnels: $(patsubst %.svg,%.svg.gz,$(wildcard ivytunnels/?/*.svg))

brc: $(patsubst %.svg,%.svg.gz,$(wildcard brc/*.svg))

sandy: $(patsubst %.svg,%.svg.gz,$(wildcard sandy/*.svg))

nyctrolleys: $(patsubst %.svg,%.svg.gz,$(wildcard nyctrolleys/*.svg))

$(regrail) nycflights:
	$(MAKE) --directory=$@

%.svg.gz : %.svg
	~/timelines/scripts/round.py < $< > $<.tmp
	mv $<.tmp $<
	gzip -f --keep $<

.SECONDEXPANSION:
%/preview.gif: $$(wildcard %/*.svg) ~/timelines/scripts/previewgif.sh
	~/timelines/scripts/previewgif.sh `dirname $@`

.PHONY: all bymode $(bymode) regrail $(regrail) hsr ivytunnels nyctrolleys nycflights 88nv
