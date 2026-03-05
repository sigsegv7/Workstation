.PHONY: all
all: rtl-tb

.PHONY: rtl-tb
rtl-tb:
	cd hw/tb/; make

.PHONY: sim
sim:
	gtkwave hw/tb/soc.vcd
