module tb_alu();
    logic [2:0] op;
    logic signed [31:0] a, b, out;
    logic zero, of;

    alu alu0 (.op(op), .a(a), .b(b), .out(out), .zero(zero), .of(of));

    initial begin
        a = 2;
        b = 3;

        $dumpfile("waveform.vcd");
        $dumpvars;
        //$dumpvars(a, b, op, out, zero, of);

        op = 0'b000;
        $strobe("%0b AND %0b = %0b", a, b, out);
        #10;

        op = 0'b001;
        $strobe("%0b OR %0b = %0b", a, b, out);
        #10;

        op = 0'b010;
        $strobe("%0d + %0d = %0d", a, b, out);
        #10;

        op = 0'b110;
        $strobe("%0d - %0d = %0d", a, b, out);
        #10;

        op = 0'b111;
        $strobe("%0d SLT %0d = %0b", a, b, out);
        #10;
    end
endmodule
