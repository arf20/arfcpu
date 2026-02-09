module memory(
    input logic [13:0] address,
    input logic chip_select,
    input logic write_enable,
    input logic output_enable,
    inout logic [31:0] data
);

    logic [31:0] mem[0:2**14-1];

    //assign data = chip_select && output_enable && !write_enable ? mem[address] : 32'bz;
    
    always_latch begin
        if (chip_select && write_enable && !output_enable)
            mem[address] = data;
    end

endmodule

