all: hsr bymode regrail sandy nyctrolleys nycflights ivytunnels 88nv

bymode = nycbymode bosbymode sfobymode berbymode alobymode cbgbymode
bymode: $(bymode)

regrail = nerail carail gbrail
regrail: $(regrail)

define previewgifRule
$(1): $(patsubst %.svg,%.svg.gz,$(wildcard $(1)/*.svg)) $(1)/preview.gif

$(1)/preview.gif: $(wildcard $(1)/*.svg) ~/timelines/scripts/previewgif.sh
	~/timelines/scripts/previewgif.sh $(1)
endef

$(foreach dir, $(bymode) brc sandy nyctrolleys, $(eval $(call previewgifRule, $(dir))))

hsr: $(patsubst %.svg,%.svg.gz,$(wildcard hsr/?/*.svg))

ivytunnels: $(patsubst %.svg,%.svg.gz,$(wildcard ivytunnels/?/*.svg))

$(regrail) nycflights:
	$(MAKE) --directory=$@

%.svg.gz : %.svg
	~/timelines/scripts/round.py < $< > $<.tmp
	mv $<.tmp $<
	gzip -f --keep $<

.PHONY: all bymode $(bymode) regrail $(regrail) hsr ivytunnels nyctrolleys nycflights 88nv
