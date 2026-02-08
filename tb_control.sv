module tb_control();
    logic clk;
    logic reset;
    logic [5:0] inst_opcode;

    logic write_pc_cond;
    logic write_pc;
    logic iod;
    logic memory_read;
    logic memory_write;
    logic [1:0] data_source;
    logic write_ir;
    logic register_dest_sel;
    logic write_register;
    logic alu_sel_a;
    logic [2:0] alu_sel_b;
    logic [1:0] alu_op;
    logic [1:0] pc_source;

    logic [3:0] debug_state;

    logic [31:0] cycle;

    control control0 (
        .clk(clk),
        .reset(reset),
        .inst_opcode(inst_opcode),

        .write_pc_cond(write_pc_cond),
        .write_pc(write_pc),
        .iod(iod),
        .memory_read(memory_read),
        .memory_write(memory_write),
        .data_source(data_source),
        .write_ir(write_ir),
        .register_dest_sel(register_dest_sel),
        .write_register(write_register),
        .alu_sel_a(alu_sel_a),
        .alu_sel_b(alu_sel_b),
        .alu_op(alu_op),
        .pc_source(pc_source),

        .debug_state(debug_state)
    );

    always begin
        #5 clk = 1;
        #5 clk = 0;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars;


        reset = 1;
        #10;
        reset = 0;

        inst_opcode = 6'h0;  // alu inst
        $strobe("opcode=%0d cycle=%0d state=%0d: write_pc_cond=%0b, write_pc=%0b, iod=%0b, memory_read=%0b, memory_write=%0b, data_source=%0b, write_ir=%0b, register_dest_sel=%0b, write_register=%0b, alu_sel_a=%0b, alu_sel_b=%0b, alu_op=%0b, pc_source=%0b", inst_opcode, cycle++, debug_state, write_pc_cond, write_pc, iod, memory_read, memory_write, data_source, write_ir, register_dest_sel, write_register, alu_sel_a, alu_sel_b, alu_op, pc_source);
        #10;
        $strobe("opcode=%0d cycle=%0d state=%0d: write_pc_cond=%0b, write_pc=%0b, iod=%0b, memory_read=%0b, memory_write=%0b, data_source=%0b, write_ir=%0b, register_dest_sel=%0b, write_register=%0b, alu_sel_a=%0b, alu_sel_b=%0b, alu_op=%0b, pc_source=%0b", inst_opcode, cycle++, debug_state, write_pc_cond, write_pc, iod, memory_read, memory_write, data_source, write_ir, register_dest_sel, write_register, alu_sel_a, alu_sel_b, alu_op, pc_source);
        #10;
        $strobe("opcode=%0d cycle=%0d state=%0d: write_pc_cond=%0b, write_pc=%0b, iod=%0b, memory_read=%0b, memory_write=%0b, data_source=%0b, write_ir=%0b, register_dest_sel=%0b, write_register=%0b, alu_sel_a=%0b, alu_sel_b=%0b, alu_op=%0b, pc_source=%0b", inst_opcode, cycle++, debug_state, write_pc_cond, write_pc, iod, memory_read, memory_write, data_source, write_ir, register_dest_sel, write_register, alu_sel_a, alu_sel_b, alu_op, pc_source);
        #10;
        $strobe("opcode=%0d cycle=%0d state=%0d: write_pc_cond=%0b, write_pc=%0b, iod=%0b, memory_read=%0b, memory_write=%0b, data_source=%0b, write_ir=%0b, register_dest_sel=%0b, write_register=%0b, alu_sel_a=%0b, alu_sel_b=%0b, alu_op=%0b, pc_source=%0b", inst_opcode, cycle++, debug_state, write_pc_cond, write_pc, iod, memory_read, memory_write, data_source, write_ir, register_dest_sel, write_register, alu_sel_a, alu_sel_b, alu_op, pc_source);
        #10;
        $strobe("opcode=%0d cycle=%0d state=%0d: write_pc_cond=%0b, write_pc=%0b, iod=%0b, memory_read=%0b, memory_write=%0b, data_source=%0b, write_ir=%0b, register_dest_sel=%0b, write_register=%0b, alu_sel_a=%0b, alu_sel_b=%0b, alu_op=%0b, pc_source=%0b", inst_opcode, cycle++, debug_state, write_pc_cond, write_pc, iod, memory_read, memory_write, data_source, write_ir, register_dest_sel, write_register, alu_sel_a, alu_sel_b, alu_op, pc_source);

    end

endmodule

