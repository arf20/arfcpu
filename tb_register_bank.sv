module tb_register_bank ();

    logic [4:0] rr1, rr2, wr;
    logic we, clk;
    logic [31:0] wd, rd1, rd2;

    register_bank rb0 (.read_reg_1(rr1), .read_reg_2(rr2), .write_reg(wr),
        .write_enable(we), .clk(clk),
        .read_data_1(rd1), .read_data_2(rd2), .write_data(wd));

    always begin
        #5 clk = 1;
        #5 clk = 0;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars;

        wr = 2;
        wd = 69;
        we = 1;
        $strobe("write %0d in %0d", wd, wr);
        #10;
        we = 0;

        rr1 = 2;
        $strobe("read %0d from %0d", rd1, rr1);
        #10;

        wr = 2;
        wd = 420;
        we = 1;
        $strobe("write %0d in %0d", wd, wr);
        #10;
        we = 0;

        rr1 = 2;
        $strobe("read %0d from %0d", rd1, rr1);
        #10;

        wr = 5;
        wd = 1234;
        we = 1;
        $strobe("write %0d in %0d", wd, wr);
        #10;
        we = 0;

        rr1 = 2;
        $strobe("read %0d from %0d", rd1, rr1);
        #10;

        rr2 = 5;
        $strobe("read %0d from %0d", rd2, rr2);
        #10;
    end
endmodule