SV_FILES = $(shell find ../rtl/ -name "*.sv")

TB_FILES =				\
	test_core.cpp

.PHONY: all
all: obj vcd

.PHONY: obj
obj:
	verilator 				 \
		-Wall 				 \
		-DCLAVBOX_SIM	 	 \
		--trace 			 \
		-cc 				 \
		-I../rtl/inc		 \
		$(SV_FILES) 		 \
		--exe $(TB_FILES) 	 \
		--top-module soc

.PHONY: vcd
vcd:
	make -C obj_dir/ -f Vsoc.mk Vsoc
	./obj_dir/Vsoc
