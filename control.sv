`include "defines.sv"

module control (
    input logic clk,
    input logic reset,
    input logic [5:0] inst_opcode,

    output logic write_pc_cond,
    output logic write_pc,
    output logic iod,
    output logic memory_read,
    output logic memory_write,
    output logic [1:0] data_source,
    output logic write_ir,
    output logic register_dest_sel,
    output logic write_register,
    output logic alu_sel_a,
    output logic [2:0] alu_sel_b,
    output logic [1:0] alu_op,
    output logic [1:0] pc_source,

    output logic [3:0] debug_state    // debug
);

    logic [3:0] state;

    `define STATE_FETCH         4'd0    // 1
    `define STATE_DECODE        4'd1    // 2
    `define STATE_EXECUTE       4'd2    // 3a ALU operation
    `define STATE_MEM_ADDR      4'd3    // 3b compute address imm
    `define STATE_COND_BRANCH   4'd4    // 3c
    `define STATE_JUMP          4'd5    // 3d
    `define STATE_WRITEBACK_IMM 4'd6    // 3e
    `define STATE_EXECUTE_IMM   4'd7    // 3f
    `define STATE_WRITEBACK     4'd8    // 4a to register rd
    `define STATE_MEM_READ      4'd9    // 4b
    `define STATE_MEM_WRITE     4'd10   // 4c
    `define STATE_WRITEBACK_RT  4'd11   // 4d
    `define STATE_MEM_WRITEBACK 4'd12   // 5

    // transition function
    always_ff @(posedge clk or posedge reset)
        if (reset)
            state = `STATE_FETCH;
        else case (state)
            `STATE_FETCH: state = `STATE_DECODE;

            `STATE_DECODE:
                case (inst_opcode)
                    `OPCODE_ALUINST: state = `STATE_EXECUTE;
                    `OPCODE_LOAD: state = `STATE_MEM_ADDR;
                    `OPCODE_STORE: state = `STATE_MEM_ADDR;
                    `OPCODE_BRANCH_EQ: state = `STATE_COND_BRANCH;
                    `OPCODE_JUMP: state = `STATE_JUMP;
                    `OPCODE_LOAD_IMM: state = `STATE_WRITEBACK_IMM;
                    `OPCODE_OR_IMM: state = `STATE_EXECUTE_IMM;
                    default: state = `STATE_FETCH;
                endcase

            `STATE_EXECUTE: state = `STATE_WRITEBACK;
            `STATE_MEM_ADDR:
                case (inst_opcode)
                    `OPCODE_LOAD: state = `STATE_MEM_READ;
                    `OPCODE_STORE: state = `STATE_MEM_WRITE;
                    default: state = `STATE_FETCH;
                endcase
            `STATE_COND_BRANCH: state = `STATE_FETCH;
            `STATE_JUMP: state = `STATE_FETCH;
            `STATE_WRITEBACK_IMM: state = `STATE_FETCH;
            
            `STATE_WRITEBACK: state = `STATE_FETCH;
            `STATE_MEM_READ: state = `STATE_MEM_WRITEBACK;
            `STATE_MEM_WRITE: state = `STATE_FETCH;
            `STATE_WRITEBACK_RT: state = `STATE_FETCH;

            `STATE_MEM_WRITEBACK: state = `STATE_FETCH;

            default: state = `STATE_FETCH;
        endcase

    // output function
    always_comb begin
        write_pc_cond = 1'b0;
        write_pc = 1'b0;
        iod = 1'bx;
        memory_read = 1'b0;
        memory_write = 1'b0;
        data_source = 2'bx;
        write_ir = 1'b0;
        register_dest_sel = 1'bx;
        write_register = 1'b0;
        alu_sel_a = 1'bx;
        alu_sel_b = 3'bx;
        alu_op = 2'bx;
        pc_source = 2'bx;

        debug_state = state;

        case (state)
            `STATE_FETCH: begin
                iod = 1'd0;
                memory_read = 1'd1;
                write_ir = 1'd1;
                alu_sel_a = 1'd0;
                alu_sel_b = 3'd1;
                alu_op = 2'd0;
                pc_source = 2'd0;
                write_pc = 1'd1;
            end
            `STATE_DECODE: begin
                alu_sel_a = 1'd0;
                alu_sel_b = 3'd3;
                alu_op = 2'd0;
            end
            `STATE_EXECUTE: begin
                alu_sel_a = 1'd1;
                alu_sel_b = 3'd0;
                alu_op = 2'd3;
            end
            `STATE_MEM_ADDR: begin
                alu_sel_a = 1'd1;
                alu_sel_b = 3'd2;
                alu_op = 2'd0;
            end
            `STATE_COND_BRANCH: begin
                alu_sel_a = 1'd1;
                alu_sel_b = 3'd0;
                alu_op = 2'd1;
                pc_source = 2'd1;
                write_pc_cond = 1'd1;
            end
            `STATE_JUMP: begin
                pc_source = 2'd2;
                write_pc = 1'd1;
            end
            `STATE_WRITEBACK_IMM: begin
                register_dest_sel = 1'd0;
                data_source = 2'd2;
                write_register = 1'd1;
            end
            `STATE_EXECUTE_IMM: begin
                alu_sel_a = 1'd1;
                alu_sel_b = 3'd4;
                alu_op = 2'd2;
            end
            `STATE_WRITEBACK: begin
                register_dest_sel = 1'd1;
                data_source = 2'd0;
                write_register = 1'd1;
            end
            `STATE_MEM_READ: begin
                iod = 1'd1;
                memory_read = 1'd1;
            end
            `STATE_MEM_WRITE: begin
                iod = 1'd1;
                memory_write = 1'd1;
            end
            `STATE_WRITEBACK_RT: begin
                register_dest_sel = 1'd0;
                data_source = 2'd0;
                register_dest_sel = 1'd1;
            end
            `STATE_MEM_WRITEBACK: begin
                register_dest_sel = 1'd0;
                data_source = 2'd1;
                write_register = 1'd1;
            end
            default: begin
                write_pc_cond = 1'b0;
                write_pc = 1'b0;
                iod = 1'bx;
                memory_read = 1'b0;
                memory_write = 1'b0;
                data_source = 2'bx;
                write_ir = 1'b0;
                register_dest_sel = 1'bx;
                write_register = 1'b0;
                alu_sel_a = 1'bx;
                alu_sel_b = 3'bx;
                alu_op = 2'bx;
                pc_source = 2'bx;
            end
        endcase
    end

endmodule

