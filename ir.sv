module ir (
    input logic [31:0] inst,    // instruction
    input logic write_enable,   // write enable
    input logic clk,            // clock

    output logic [5:0] opcode,  // opcode
    output logic [4:0] rs,      // source register
    output logic [4:0] rt,      // source/destination register
    output logic [15:0] imm,    // immediate data
    output logic [4:0] rd,      // destination register
    output logic [4:0] shamt,   // shift amount
    output logic [5:0] func,    // arithmetic logic function
    output logic [25:0] j       // arithmetic logic function
);

    // register
    logic [31:0] inst_reg;

    // write to register on clock when if enable
    always_ff @(posedge clk) begin
        if (write_enable) begin
            inst_reg <= inst;
        end
    end

    // decode instruction always
    always_comb begin
        opcode = inst_reg[31:26];
        rs = inst_reg[25:21];
        rt = inst_reg[20:16];
        imm = inst_reg[15:0];
        rd = inst_reg[15:11];
        shamt = inst_reg[10:6];
        func = inst_reg[5:0];
        j = inst_reg[25:0];
    end

endmodule

