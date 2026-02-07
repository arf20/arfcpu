module register_bank (
    input logic [4:0] read_reg_1,       // read port 1 address
    input logic [4:0] read_reg_2,       // read port 2 address
    input logic [4:0] write_reg,        // write port address
    input logic [31:0] write_data,      // write data
    input logic write_enable,           // write enable
    input logic clk,                    // clock

    output logic [31:0] read_data_1,    // read port 1 data 
    output logic [31:0] read_data_2     // read port 2 data
);

    logic [31:0] registers[32];         // 31 32-bit registers

    initial registers[0] = 32'b0;       // $0 is 0

    // write port on clock if write enable
    always_ff @(posedge clk) begin
        if (write_enable && write_reg != 5'b0) begin
            registers[write_reg] = write_data;
        end
    end

    // read is always combinational
    always_comb begin
        read_data_1 = registers[read_reg_1];
        read_data_2 = registers[read_reg_2];
    end

endmodule
