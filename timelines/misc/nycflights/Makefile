all: $(patsubst routes%,%.svg.gz,$(wildcard routes????)) $(patsubst routes%,%.svg,$(wildcard routes????))

%.svg : routes% scripts/makeyear.sh scripts/path.pl scripts/circ.pl
	scripts/makeyear.sh $*

%.svg.gz : %.svg
	gzip -f --keep $<

.PHONY: all
