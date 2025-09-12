`timescale 1ns/1ps

module Tb_RISC_MIPS;

  // ---------------------------
  // Signals
  // ---------------------------
  reg CLK1, CLK2, RST;
  integer k;

  // ---------------------------
  // Instantiate CPU
  // ---------------------------
  RISC_MIPS cpu (
    .CLK1(CLK1),
    .CLK2(CLK2),
    .RST(RST)
  );

  // ---------------------------
  // Two-phase clock generation
  // ---------------------------
  initial begin
    CLK1 = 0; CLK2 = 0;
    forever begin
      #5  CLK1 = 1; #5  CLK1 = 0;
      #5  CLK2 = 1; #5  CLK2 = 0;
    end
  end

  // ---------------------------
  // Test program
  // ---------------------------
  initial begin
    // Reset CPU
    RST = 1;
    #10 RST = 0;

    // Clear memory and registers
    for (k = 0; k < 1024; k = k + 1) cpu.MEM[k] = 32'd0;
    for (k = 0; k < 32;   k = k + 1) cpu.REG_FILE[k] = 32'd0;

    // ---------------------------
    // Load instructions into memory
    // ---------------------------

    // Immediate instructions
    cpu.MEM[0]  = {6'b001010, 5'd0, 5'd1, 16'd0};    // ADDI R1,R0,5
    cpu.MEM[1]  = {6'b001010, 5'd0, 5'd2, 16'd10};   // ADDI R2,R0,10
    cpu.MEM[2]  = {6'b000000, 21'd0};                // NOP
    cpu.MEM[3]  = {6'b000000, 21'd0};                // NOP

    // ALU operations
    cpu.MEM[4]  = {6'b000000, 5'd1, 5'd2, 5'd3, 11'd0}; // ADD R3,R1,R2
    cpu.MEM[5]  = {6'b000001, 5'd2, 5'd3, 5'd4, 11'd0}; // SUB R4,R2,R1
    cpu.MEM[6]  = {6'b000010, 5'd1, 5'd2, 5'd5, 11'd0}; // AND R5,R1,R2
    cpu.MEM[7]  = {6'b000011, 5'd1, 5'd2, 5'd6, 11'd0}; // OR  R6,R1,R2
    cpu.MEM[8]  = {6'b000100, 5'd1, 5'd2, 5'd7, 11'd0}; // SLT R7,R1,R2
    cpu.MEM[9]  = {6'b000101, 5'd1, 5'd2, 5'd8, 11'd0}; // MUL R8,R1,R2

    // More immediate instructions
    cpu.MEM[10] = {6'b001010, 5'd1, 5'd9, 16'd15};   // ADDI R9,R1,15
    cpu.MEM[11] = {6'b001011, 5'd2, 5'd10,16'd3};    // SUBI R10,R2,3
    cpu.MEM[12] = {6'b001100, 5'd2, 5'd11,16'd20};   // SLTI R11,R2,20

    // Memory operations
    cpu.MEM[13] = {6'b001001, 5'd0, 5'd3, 16'd40};   // SW R3,30(R0)
    cpu.MEM[14] = {6'b000000, 21'd0};                // NOP
    cpu.MEM[15] = {6'b000000, 21'd0};                // NOP
    cpu.MEM[16] = {6'b001000, 5'd0, 5'd12,16'd40};   // LW R12,30(R0)
    cpu.MEM[17] = {6'b000000, 21'd0};                // NOP

    // Branch instructions
    cpu.MEM[18] = {6'b001110, 5'd1, 5'd0, 16'd5};    // BEQZ R1, skip5
    cpu.MEM[19] = {6'b000000, 21'd0};               // NOP
    cpu.MEM[20] = {6'b000101, 5'd1,5'd2,5'd13,11'd0}; // MUL R8,R1,R2
    cpu.MEM[21] = {6'b001010, 5'd1, 5'd14, 16'd15}; // ADDI R14,R1,15
    cpu.MEM[22] = {6'b001011, 5'd2, 5'd15,16'd3};   // SUBI R15,R2,3
    cpu.MEM[23] = {6'b001010, 5'd1, 5'd16,16'd15};  // ADDI R16,R1,15
    cpu.MEM[24] = {6'b001010, 5'd1, 5'd17,16'd17};  // ADDI R17,R1,17

    cpu.MEM[25] = {6'b001101, 5'd2, 5'd0, 16'd3};   // BNEQZ R2, skip2
    cpu.MEM[26] = {6'b000000, 5'd0,5'd0,5'd18,11'd0}; // NOP
    cpu.MEM[27] = {6'b001011, 5'd2, 5'd19,16'd3};   // SUBI R19,R2,3
    cpu.MEM[28] = {6'b001100, 5'd2, 5'd20,16'd20};  // SLTI R20,R2,20
    cpu.MEM[29] = {6'b001010, 5'd2, 5'd21,16'd3};   // ADDI R21,R2,3
    cpu.MEM[30] = {6'b001010, 5'd4, 5'd22,16'd10};  // ADDI R22,R4,10
    cpu.MEM[31] = {6'b000011, 5'd1, 5'd2, 5'd23, 11'd0}; // OR R23,R1,R2
    cpu.MEM[32] = {6'b001011, 5'd2, 5'd24,16'd8};   // SUBI R24,R2,8
    cpu.MEM[33] = {6'b001010, 5'd2, 5'd25,16'd5};   // ADDI R25,R2,5

    // HALT instruction
    cpu.MEM[34] = {6'b111111, 26'd0};               // HLT
    cpu.MEM[35] = {6'b000000, 21'd0};               // NOP (after HLT)
    
    // Instructions after HALT (should not execute)
    cpu.MEM[36] = {6'b001100, 5'd2, 5'd26,16'd16};  // SLTI R26,R2,16
    cpu.MEM[37] = {6'b001011, 5'd2, 5'd27,16'd3};   // SUBI R27,R2,3
    cpu.MEM[38] = {6'b001100, 5'd2, 5'd28,16'd7};   // SLTI R28,R2,7
    cpu.MEM[39] = {6'b001011, 5'd2, 5'd29,16'd4};   // SUBI R29,R2,4

    // ---------------------------
    // Wait for execution
    // ---------------------------
    #1000;

    // ---------------------------
    // Display results
    // ---------------------------
    $display("R1  = %d (expect 5)",   cpu.REG_FILE[1]);
    $display("R2  = %d (expect 10)",  cpu.REG_FILE[2]);
    $display("R3  = %d (expect 15)",  cpu.REG_FILE[3]);
    $display("R4  = %d (expect 5)",   cpu.REG_FILE[4]);
    $display("R5  = %d (expect 0)",   cpu.REG_FILE[5]);
    $display("R6  = %d (expect 15)",  cpu.REG_FILE[6]);
    $display("R7  = %d (expect 1)",   cpu.REG_FILE[7]);
    $display("R8  = %d (expect 50)",  cpu.REG_FILE[8]);
    $display("R9  = %d (expect 20)",  cpu.REG_FILE[9]);
    $display("R10 = %d (expect 7)",   cpu.REG_FILE[10]);
    $display("R11 = %d (expect 1)",   cpu.REG_FILE[11]);
    $display("MEM[30] = %d (expect 15)", cpu.MEM[30]);
    $display("R12 = %d (expect 15)",  cpu.REG_FILE[12]);
    $display("R13 = %d (expect 0, skipped by branch)", cpu.REG_FILE[13]);
    $display("R26 = %d (expect 0, after HLT)", cpu.REG_FILE[26]);
    $display("R27 = %d (expect 0, after HLT)", cpu.REG_FILE[27]);
    $display("R28 = %d (expect 0, after HLT)", cpu.REG_FILE[28]);
    $display("R29 = %d (expect 0, after HLT)", cpu.REG_FILE[29]);

    $stop;
  end

endmodule
