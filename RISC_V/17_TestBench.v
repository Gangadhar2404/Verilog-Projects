`timescale 1ns/1ps

module tb_TopModule;

  reg clk, rst;
  integer i;

  TopModule UUT (.clk(clk), .rst(rst));

  // Clock
  initial clk = 0;
  always #5 clk = ~clk;  

  initial begin
    rst = 1; #10; rst = 0;

    // --------------------------
    // Program in instruction memory
    // --------------------------
    UUT.FC.IMEM.I_Mem[0]  = 32'b000000001010_00000_000_00001_0010011; // addi x1,x0,10
    UUT.FC.IMEM.I_Mem[1]  = 32'b000000010100_00000_000_00010_0010011; // addi x2,x0,20
    UUT.FC.IMEM.I_Mem[2]  = 32'b000000000000_00000_000_00000_0010011; // nop
    UUT.FC.IMEM.I_Mem[3]  = 32'b000000000000_00000_000_00000_0010011; // nop
    UUT.FC.IMEM.I_Mem[4]  = 32'b000000000000_00000_000_00000_0010011; // nop
    UUT.FC.IMEM.I_Mem[5]  = 32'b0000000_00010_00001_000_00011_0110011; // add  x3,x1,x2
    UUT.FC.IMEM.I_Mem[6]  = 32'b0100000_00001_00010_000_00100_0110011; // sub  x4,x2,x1
    UUT.FC.IMEM.I_Mem[7]  = 32'b0000000_00010_00001_001_00101_0110011; // sll  x5,x1,x2
    UUT.FC.IMEM.I_Mem[8]  = 32'b0000000_00010_00001_101_00110_0110011; // srl  x6,x1,x2
    UUT.FC.IMEM.I_Mem[9]  = 32'b0000000_00010_00001_100_00111_0110011; // xor  x7,x1,x2
    UUT.FC.IMEM.I_Mem[10] = 32'b0000000_00010_00001_110_01000_0110011; // or   x8,x1,x2
    UUT.FC.IMEM.I_Mem[11] = 32'b0000000_00010_00001_111_01001_0110011; // and  x9,x1,x2
    UUT.FC.IMEM.I_Mem[12] = 32'b000000001010_00001_000_01010_0010011;  // addi x10,x1,10
    UUT.FC.IMEM.I_Mem[13] = 32'b000000000001_00001_001_01100_0010011;  // slli x12,x1,1
    UUT.FC.IMEM.I_Mem[14] = 32'b000000000001_00001_101_01101_0010011;  // srli x13,x1,1
    UUT.FC.IMEM.I_Mem[15] = 32'b000000001010_00001_100_01110_0010011;  // xori x14,x1,10
    UUT.FC.IMEM.I_Mem[16] = 32'b000000000101_00001_110_01111_0010011;  // ori  x15,x1,5
    UUT.FC.IMEM.I_Mem[17] = 32'b000000001010_00001_111_10000_0010011;  // andi x16,x1,10
    UUT.FC.IMEM.I_Mem[18] = 32'b000000000011_00001_010_10001_0100011;  // sw   x3,17(x1)
    UUT.FC.IMEM.I_Mem[19] = 32'b000000000000_00000_000_00000_0010011;  // nop
    UUT.FC.IMEM.I_Mem[20] = 32'b000000000000_00000_000_00000_0010011;  // nop
    UUT.FC.IMEM.I_Mem[21] = 32'b000000000000_00000_000_00000_0010011;  // nop
    UUT.FC.IMEM.I_Mem[22] = 32'b000000010001_00001_010_10010_0000011;  // lw   x18,17(x1)
    UUT.FC.IMEM.I_Mem[23] = 32'b0000000_00100_00001_000_10100_1100011; // beq  x1,x4,+20
    UUT.FC.IMEM.I_Mem[24] = 32'b0000000_01010_01001_000_10100_0110011; // add  x20,x9,x10
    UUT.FC.IMEM.I_Mem[25] = 32'b0000000_10000_01111_100_10101_0110011; // xor  x21,x15,x16
    UUT.FC.IMEM.I_Mem[26] = 32'b0000000_01110_01101_110_10110_0110011; // or   x22,x13,x14
    UUT.FC.IMEM.I_Mem[27] = 32'b0000000_01100_01011_111_10111_0110011; // and  x23,x11,x12
    UUT.FC.IMEM.I_Mem[28] = 32'b0000000_10001_00100_000_11000_0110011; // add  x24,x4,x17
    UUT.FC.IMEM.I_Mem[29] = 32'b0000000_11000_01010_100_11001_0110011; // xor  x25,x10,x24
    UUT.FC.IMEM.I_Mem[30] = 32'b000000000101_00011_000_11010_0010011;  // addi x26,x3,5
    UUT.FC.IMEM.I_Mem[31] = 32'b0000000_00100_00011_111_11011_0110011; // and  x27,x3,x4
    UUT.FC.IMEM.I_Mem[32] = 32'b0000000_00011_00011_000_11100_0110011; // add  x28,x3,x3
    UUT.FC.IMEM.I_Mem[33] = 32'b0000000_00000_00100_110_11101_0110011; // or   x29,x4,x0

    // --------------------------
    // Print all 32 registers
    // --------------------------
    // --------------------------
// Print register file (all 32)
// --------------------------
$display("Cycle | x0 | x1 | x2 | x3 | x4 | x5 | x6 | x7 | x8 | x9 | x10 | x11 | x12 | x13 | x14 | x15 | x16 | x17 | x18 | x19 | x20 | x21 | x22 | x23 | x24 | x25 | x26 | x27 | x28 | x29 | x30 | x31");
$display("--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------");

for(i=0; i<50; i=i+1) begin
  #10;
  $display("%2d    | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d | %3d",
           i,
           UUT.DC.RB.Reg_Bank[0],
           UUT.DC.RB.Reg_Bank[1],
           UUT.DC.RB.Reg_Bank[2],
           UUT.DC.RB.Reg_Bank[3],
           UUT.DC.RB.Reg_Bank[4],
           UUT.DC.RB.Reg_Bank[5],
           UUT.DC.RB.Reg_Bank[6],
           UUT.DC.RB.Reg_Bank[7],
           UUT.DC.RB.Reg_Bank[8],
           UUT.DC.RB.Reg_Bank[9],
           UUT.DC.RB.Reg_Bank[10],
           UUT.DC.RB.Reg_Bank[11],
           UUT.DC.RB.Reg_Bank[12],
           UUT.DC.RB.Reg_Bank[13],
           UUT.DC.RB.Reg_Bank[14],
           UUT.DC.RB.Reg_Bank[15],
           UUT.DC.RB.Reg_Bank[16],
           UUT.DC.RB.Reg_Bank[17],
           UUT.DC.RB.Reg_Bank[18],
           UUT.DC.RB.Reg_Bank[19],
           UUT.DC.RB.Reg_Bank[20],
           UUT.DC.RB.Reg_Bank[21],
           UUT.DC.RB.Reg_Bank[22],
           UUT.DC.RB.Reg_Bank[23],
           UUT.DC.RB.Reg_Bank[24],
           UUT.DC.RB.Reg_Bank[25],
           UUT.DC.RB.Reg_Bank[26],
           UUT.DC.RB.Reg_Bank[27],
           UUT.DC.RB.Reg_Bank[28],
           UUT.DC.RB.Reg_Bank[29],
           UUT.DC.RB.Reg_Bank[30],
           UUT.DC.RB.Reg_Bank[31]);
end

    $finish;
  end
endmodule
