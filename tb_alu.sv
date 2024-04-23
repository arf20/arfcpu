module tb_alu();
    logic [2:0] op;
    logic [31:0] a, b, out;

    alu alu0 (.op(op), .a(a), .b(b), .out(out));

    initial begin
        a <= 2;
        b <= 3;

        op = 0'b000;
        $monitor ("%0b AND %0b = %0b",
            a, b, op, out);
        #10;

        op = 0'b001;
        $monitor ("%0b OR %0b = %0b",
            a, b, op, out);
        #10;

        op = 0'b010;
        $monitor ("%0b + %0b = %0b",
            a, b, op, out);
        #10;

        op = 0'b110;
        $monitor ("%0b - %0b = %0b",
            a, b, op, out);
        #10;

        op = 0'b111;
        $monitor ("%0b SLT %0b = %0b",
            a, b, op, out);
        #10;

    end

endmodule