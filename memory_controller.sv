module memoryctl (
    input logic clk,
    input logic read_enable,
    input logic write_enable,
    input logic [31:0] address,
    input logic [31:0] write_data,
    output logic [31:0] read_data,

    output logic [31:0] bus_address;
    inout logic [7:0] bus_data;
);

    always_comb begin
        bus_address = address;

    end

    

endmodule

