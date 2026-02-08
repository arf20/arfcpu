`ifndef _DEFINES
`define _DEFINES

// opcodes
typedef enum logic [5:0] {
    OPCODE_ALUINST    = 6'd0,   // add,sub,slt,and,or
    OPCODE_LOAD       = 6'd35,  // lw
    OPCODE_STORE      = 6'd43,  // sw
    OPCODE_BRANCH_EQ  = 6'd4,   // beq
    OPCODE_JUMP       = 6'd2,   // j
    OPCODE_LOAD_IMM   = 6'd15,  // lui
    OPCODE_OR_IMM     = 6'd13   // ori
} opcode_t;

`endif

