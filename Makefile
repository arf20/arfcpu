all: obj/Valu

obj/Valu: alu.sv tb_alu.sv
	verilator --timing --timescale-override 1ps/1ps --trace --assert --binary alu.sv tb_alu.sv

