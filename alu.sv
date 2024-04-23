module alu (
    input logic [2:0] op,           // operation
    input logic signed [31:0] a, b, // inputs

    output logic signed [31:0] out, // output
    output logic zero,              // carry out
    output logic of                 // overflow
        );

    always_comb begin
        if (op == 0) begin
            out = a & b;
            of = 0;
        end
        else if (op == 1) begin
            out = a | b;
            of = 0;
        end
        else if (op == 2) begin
            out = a + b;
            of = (a >= 0) && (b >= 0) && (out < 0) || (a < 0) && (b < 0) && (out >= 0);
        end
        else if (op == 6) begin
            out = a - b;
            of = (a >= 0) && (b < 0) && (out < 0) || (a < 0) && (b >= 0) && (out >= 0);
        end
        else if (op == 7) begin
            out = { 31'b0, a < b };
            of = 0;
        end
        else begin
            out = 0;
            of = 0;
        end

        zero = out == 0;
    end

endmodule
