VERILATOR := verilator

OBJ_DIR := obj_dir

all: $(OBJ_DIR)/Valu $(OBJ_DIR)/Vregister_bank $(OBJ_DIR)/Vinstruction_register

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(OBJ_DIR)/Valu: alu.sv tb_alu.sv | $(OBJ_DIR)
	$(VERILATOR) --timing --timescale-override 1ps/1ps --trace --assert --binary alu.sv tb_alu.sv

$(OBJ_DIR)/Vregister_bank: register_bank.sv tb_register_bank.sv | $(OBJ_DIR)
	$(VERILATOR) --timing --timescale-override 1ps/1ps --trace --assert --binary register_bank.sv tb_register_bank.sv

$(OBJ_DIR)/Vinstruction_register: instruction_register.sv tb_ir.sv | $(OBJ_DIR)
	$(VERILATOR) --timing --timescale-override 1ps/1ps --trace --assert --binary instruction_register.sv tb_ir.sv

$(OBJ_DIR)/Vcontrol: control.sv tb_control.sv | $(OBJ_DIR)
	$(VERILATOR) --timing --timescale-override 1ps/1ps --trace --assert --binary control.sv tb_control.sv

clean:
	rm -rf $(OBJ_DIR)

.PHONY: all clean

