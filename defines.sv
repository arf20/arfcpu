`ifndef _DEFINES
`define _DEFINES

// opcodes
`define OPCODE_ALUINST      6'd0    // add,sub,slt,and,or
`define OPCODE_LOAD         6'd35   // lw
`define OPCODE_STORE        6'd43   // sw
`define OPCODE_BRANCH_EQ    6'd4    // beq
`define OPCODE_JUMP         6'd2    // j
`define OPCODE_LOAD_IMM     6'd15   // lui
`define OPCODE_OR_IMM       6'd13   // ori

`endif

