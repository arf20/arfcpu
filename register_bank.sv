module register_bank (
    input logic [4:0] read_reg_1,
    input logic [4:0] read_reg_2,
    input logic [4:0] write_reg,
    input logic [31:0] write_data,
    input logic write_enable,
    input logic clk,

    output logic [31:0] read_data_1,
    output logic [31:0] read_data_2
);

    logic [31:0] registers[32];

    always_ff @(posedge clk) begin
        if (write_enable) begin
            registers[write_reg] = write_data;
        end
    end

    always_comb begin
        read_data_1 = registers[read_reg_1];
        read_data_2 = registers[read_reg_2];
    end

endmodule
