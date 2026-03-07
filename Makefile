.PHONY: all
all: firmware rtl-tb

.PHONY: firmware
firmware:
	tools/bin2mem firmware/fw.bin hw/tb/fw.mem
	cp hw/tb/fw.mem hw/board/altera/5cseba6u23l7/

.PHONY: rtl-tb
rtl-tb:
	cd hw/tb/; make

.PHONY: sim
sim:
	gtkwave hw/tb/soc.vcd
