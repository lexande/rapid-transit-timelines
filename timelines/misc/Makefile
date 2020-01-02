all: hsr bymode regrail sandy nyctrolleys nycflights 

bymode = nycbymode bosbymode sfobymode harvardtunnel
bymode: $(bymode)

regrail = nerail carail
regrail: $(regrail)

define gzipRule
$(1): $(patsubst %.svg,%.svg.gz,$(wildcard $(1)/*.svg))
endef

$(foreach dir, $(bymode) brc sandy nyctrolleys, $(eval $(call gzipRule, $(dir))))

hsr: $(patsubst %.svg,%.svg.gz,$(wildcard hsr/?/*.svg))

$(regrail) nycflights:
	$(MAKE) --directory=$@

%.svg.gz : %.svg
	gzip -f --keep $<

.PHONY: all bymode $(bymode) regrail $(regrail) hsr nyctrolleys nycflights brc
.SECONDARY:
