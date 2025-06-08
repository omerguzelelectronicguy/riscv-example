SV_FILES = $(wildcard ./src/pkg/*.sv) $(wildcard ./src/*.sv)
TB_FILES = $(wildcard ./tb/*.sv)
ALL_FILES = $(SV_FILES) $(TB_FILES)

lint:
	@echo "Linting all SystemVerilog files..."
	@echo "----------------------------------------"
	verilator --lint-only -Wall -Wno-UNUSED --timing $(ALL_FILES)
build:
	verilator --binary $(SV_FILES) ./tb/tb.sv --top tb -j 0 --trace -Wno-UNOPTFLAT
run: build
	./obj_dir/Vtb

wave: run
	gtkwave --dark dump.vcd

clean:
	@echo "Cleaning up..."
	rm -rf obj_dir;
	rm -f dump.vcd
	rm pc.log

.PHONY: all lint build run wave clean
