module tb_memory();
    logic [13:0] addr;
    logic [31:0] data;
    logic cs, we, oe;

    memory memory0(.address(addr), .chip_select(cs), .write_enable(we), .output_enable(oe), .data(data));

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars;

        addr = 14'h0;
        data = 32'hf;
        cs = 1;
        we = 1;
        oe = 0;
        $strobe("write %0h to %0h", data, addr);
        #10;

    end

endmodule

