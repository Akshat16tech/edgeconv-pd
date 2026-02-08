VERILOG_SRC = ../src/edgeconv.v ../src/edgeconv_top.v tb_edgeconv.v
TOP = tb_edgeconv

.PHONY: all compile sim clean wave

all: compile sim

compile:
	iverilog -g2012 -o $(TOP).vvp $(VERILOG_SRC)
	@echo "✅ Compilation successful"

sim: compile
	vvp $(TOP).vvp
	@echo "✅ Simulation complete"

wave:
	gtkwave $(TOP).vcd &

clean:
	rm -f *.vvp *.vcd
