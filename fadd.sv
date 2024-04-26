module fadd (
    input logic [31:0] a, b,
    input logic cin,
    output logic [31:0] out
);

    always_comb begin
        out = cin + a + b;
    end
endmodule
