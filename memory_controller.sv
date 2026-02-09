module memoryctl (
    input logic read_enable,
    input logic write_enable,
    input logic [31:0] address,
    input logic [31:0] write_data,
    output logic [31:0] read_data,

    output logic [31:0] bus_address,
    inout logic [31:0] bus_data,
    output logic bus_rd,
    output logic bus_wr
);

    always_comb begin
        bus_address = address;
        bus_rd = read_enable;
        bus_wr = write_enable;

        assign bus_data = write_enable ? write_data : 32'bz;
        assign read_data = read_enable ? bus_data : 32'b0;

    end

endmodule

