all: hsr bymode regrail sandy nyctrolleys nycflights 

bymode = nycbymode bosbymode sfobymode harvardtunnel
bymode: $(bymode)

regrail = nerail carail
regrail: $(regrail)

$(bymode) brc sandy nyctrolleys: $(patsubst %.svg,%.svg.gz,$(wildcard $@/*.svg))

hsr: $(patsubst %.svg,%.svg.gz,$(wildcard hsr/?/*.svg))

$(regrail) nycflights:
	$(MAKE) --directory=$@

%.svg.gz : %.svg
	gzip -f --keep $<

.PHONY: all bymode $(bymode) regrail $(regrail) hsr nyctrolleys nycflights brc
.SECONDARY:
