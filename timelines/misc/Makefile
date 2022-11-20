all: hsr bymode regrail sandy nyctrolleys nycflights ivytunnels brc

bymode = nycbymode bosbymode sfobymode alobymode cbgbymode
bymode: $(bymode)

regrail = nerail carail gbrail
regrail: $(regrail)

define gzipRule
$(1): $(patsubst %.svg,%.svg.gz,$(wildcard $(1)/*.svg)) $(1)/preview.gif

$(1)/preview.gif: $(wildcard $(1)/*.svg) ~/timelines/scripts/previewgif.sh
	~/timelines/scripts/previewgif.sh $(1)
endef

$(foreach dir, $(bymode) brc sandy nyctrolleys, $(eval $(call gzipRule, $(dir))))

hsr: $(patsubst %.svg,%.svg.gz,$(wildcard hsr/?/*.svg))

ivytunnels: $(patsubst %.svg,%.svg.gz,$(wildcard ivytunnels/?/*.svg))

$(regrail) nycflights:
	$(MAKE) --directory=$@

%.svg.gz : %.svg
	gzip -f --keep $<

.PHONY: all bymode $(bymode) regrail $(regrail) hsr ivytunnels nyctrolleys nycflights brc
