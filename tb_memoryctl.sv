module tb_memoryctl();
    logic [31:0] addr;
    logic we, re;

    logic [31:0] read_data, write_data;

    logic [31:0] bus_addr, bus_data;
    logic bus_rd, bus_wr;

    memoryctl memoryctl0 (
        .read_enable(re),
        .write_enable(we),
        .address(addr),
        .write_data(write_data),
        .read_data(read_data),
        .bus_address(bus_addr),
        .bus_data(bus_data),
        .bus_rd(bus_rd),
        .bus_wr(bus_wr)
    );

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars;

        addr = 32'h1234abcd;

        write_data = 32'h0;
        bus_data = 32'hf;
        we = 0;
        re = 1;
        #1;
        $strobe("read %0h at %0h -> %0d at %0h (%0b %0b)", read_data, addr, bus_data, bus_addr, bus_rd, bus_wr);
        #10;

        write_data = 32'hf0;
        bus_data = 32'b0;
        we = 1;
        re = 0;
        #1;
        $strobe("write %0h at %0h -> %0d at %0h (%0b %0b)", write_data, addr, bus_data, bus_addr, bus_rd, bus_wr);
        #10;

        write_data = 32'h0;
        bus_data = 32'hf00;
        we = 0;
        re = 1;
        #1;
        $strobe("read %0h at %0h -> %0d at %0h (%0b %0b)", read_data, addr, bus_data, bus_addr, bus_rd, bus_wr);
        #10;

        bus_data = 32'hf000;
        we = 0;
        re = 1;
        #1;
        $strobe("read %0h at %0h -> %0d at %0h (%0b %0b)", read_data, addr, bus_data, bus_addr, bus_rd, bus_wr);
        #10;

        write_data = 32'hf0000;
        bus_data = 32'b0;
        we = 1;
        re = 0;
        #1;
        $strobe("write %0h at %0h -> %0d at %0h (%0b %0b)", write_data, addr, bus_data, bus_addr, bus_rd, bus_wr);
        #10;

        write_data = 32'h0;
        bus_data = 32'hf00000;
        we = 0;
        re = 1;
        #1;
        $strobe("read %0h at %0h -> %0d at %0h (%0b %0b)", read_data, addr, bus_data, bus_addr, bus_rd, bus_wr);
        #10;
    end

endmodule

