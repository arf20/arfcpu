all: obj/Valu obj/Vregister_bank

obj/Valu: alu.sv tb_alu.sv
	verilator --timing --timescale-override 1ps/1ps --trace --assert --binary alu.sv tb_alu.sv

obj/Vregister_bank: register_bank.sv tb_register_bank.sv
	verilator --timing --timescale-override 1ps/1ps --trace --assert --binary register_bank.sv tb_register_bank.sv

