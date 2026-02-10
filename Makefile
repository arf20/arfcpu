VERILATOR := verilator
VERFLAGS := --timing --timescale-override 1ps/1ps --trace --assert --binary -Wall

OBJ_DIR := obj_dir

all: $(OBJ_DIR)/Valu $(OBJ_DIR)/Vregister_bank $(OBJ_DIR)/Vir $(OBJ_DIR)/Vcontrol $(OBJ_DIR)/Vmemoryctl $(OBJ_DIR)/Vmemory

$(OBJ_DIR):
	mkdir -p $(OBJ_DIR)

$(OBJ_DIR)/Valu: alu.sv tb_alu.sv | $(OBJ_DIR)
	$(VERILATOR) $(VERFLAGS) alu.sv tb_alu.sv

$(OBJ_DIR)/Vregister_bank: register_bank.sv tb_register_bank.sv | $(OBJ_DIR)
	$(VERILATOR) $(VERFLAGS) register_bank.sv tb_register_bank.sv

$(OBJ_DIR)/Vir: ir.sv tb_ir.sv | $(OBJ_DIR)
	$(VERILATOR) $(VERFLAGS) ir.sv tb_ir.sv

$(OBJ_DIR)/Vcontrol: control.sv tb_control.sv | $(OBJ_DIR)
	$(VERILATOR) $(VERFLAGS) control.sv tb_control.sv

$(OBJ_DIR)/Vmemoryctl: memoryctl.sv tb_memoryctl.sv | $(OBJ_DIR)
	$(VERILATOR) $(VERFLAGS) memoryctl.sv tb_memoryctl.sv

$(OBJ_DIR)/Vmemory: memory.sv tb_memory.sv | $(OBJ_DIR)
	$(VERILATOR) $(VERFLAGS) memory.sv tb_memory.sv

clean:
	rm -rf $(OBJ_DIR)

.PHONY: all clean

