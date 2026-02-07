module tb_alu();
    logic [31:0] inst;
    logic clk;
    logic we;

    logic [5:0] opcode;
    logic [4:0] rs;
    logic [4:0] rt;
    logic [15:0] imm;
    logic [4:0] rd;
    logic [4:0] shamt;
    logic [5:0] func;
    logic [25:0] j;

    ir ir0 (.inst(inst), .clk(clk), .write_enable(we), .opcode(opcode), .rs(rs), .rt(rt), .imm(imm), .rd(rd), .shamt(shamt), .func(func), .j(j));

    always begin
        #5 clk = 1;
        #5 clk = 0;
    end

    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars;

        // R format
        inst = 32'h02494020;  // add $8,$18,$9
        we = 1;
        #10;
        $strobe("add $8,$18,$9 => op=%0b, rs=%0b, rt=%0b, rd=%0b, shamt=%0b, func=%0b", opcode, rs, rt, rd, shamt, func);
        we = 0;

        inst = 32'h000920e3;  // sra $8,$18,7
        we = 1;
        #10;
        $strobe("sra $8,$18,7 => op=%0b, rs=%0b, rt=%0b, rd=%0b, shamt=%0b, func=%0b", opcode, rs, rt, rd, shamt, func);
        we = 0;
       
        // I format
        inst = 32'h3651000f; // ori $17,$18,15
        we = 1;
        #10;
        $strobe("ori $17,$18,15 => op=%0b, rs=%0b, rt=%0b, imm=%0b", opcode, rs, rt, imm);
        we = 0;
        
        inst = 32'h8e510064; // lw $17,100($18)
        we = 1;
        #10;
        $strobe("lw $17,100($18) => op=%0b, rs=%0b, rt=%0b, imm=%0b", opcode, rs, rt, imm);
        we = 0;

        inst = 32'hae51ffce; // sw $17,-50($18)
        we = 1;
        #10;
        $strobe("sw $17,-50($18) => op=%0b, rs=%0b, rt=%0b, imm=%0b", opcode, rs, rt, imm);
        we = 0;

        inst = 32'h3c080400; // lui $8,1024
        we = 1;
        #10;
        $strobe("lui $8,1024 => op=%0b, rs=%0b, rt=%0b, imm=%0b", opcode, rs, rt, imm);
        we = 0;

        inst = 32'h11150002; // beq $8,$21,+3i
        we = 1;
        #10;
        $strobe("beq $8,$21,+3i => op=%0b, rs=%0b, rt=%0b, imm=%0b", opcode, rs, rt, imm);
        we = 0;

        inst = 32'h08100003; // j 0x0040000c
        we = 1;
        #10;
        $strobe("j 0x0040000c => op=%0b, j=%0b", opcode, j);
        we = 0;

    end
endmodule
