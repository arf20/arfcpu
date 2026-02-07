module adder (
    input logic [31:0] a, b,    // inputs
    input logic cin,            // carry in
    output logic [31:0] out     // output
);

    always_comb begin
        out = a + b + { 31'b0, cin };
    end
endmodule
