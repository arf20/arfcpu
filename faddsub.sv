module faddsub (
    input logic signed [31:0] a, b,
    input logic sub,
    output logic signed [31:0] out
);

    always_comb begin
        case (sub)
            0: out = a + b;
            1: out = a + (~b + 1);
        endcase
    end
endmodule
