typedef enum logic [2:0] { 
    OP_AND =    3'b000,
    OP_OR =     3'b001,
    OP_ADD =    3'b010,
    OP_SUB =    3'b110,
    OP_SLT =    3'b111
 } op_t;

module alu (
    input op_t op,                  // operation
    input logic signed [31:0] a, b, // inputs

    output logic signed [31:0] out, // output
    output logic zero,              // zero
    output logic of                 // overflow
);

    logic signed [31:0] addout;

    faddsub faddsub0(.a(a), .b(b), .sub(op[2]), .out(addout));

    always_comb begin
        case (op)
            OP_AND: out = a & b;
            OP_OR:  out = a | b;
            OP_ADD: out = addout;
            OP_SUB: out = addout;
            OP_SLT: out = { 31'b0, a < b };
            default begin
                out = 0;
            end
        endcase

        of =  ~op[2] & ~a[31] & ~b[31] &  out[31] 
            | ~op[2] &  a[31] &  b[31] & ~out[31]
            |  op[2] & ~a[31] &  b[31] &  out[31] 
            |  op[2] &  a[31] & ~b[31] & ~out[31];

        zero = out == 0;
    end
endmodule
