module TopModule(
  input clk,
  input rst,
  output Zero_flag,
  output Negative_flag,
  output Overflow_flag,
  output Cout_flag
);

  wire [31:0] PC_Top, RD_Instr, RD1_TOP, imm_ex_top;
  wire [31:0] ALU_RESULT_TOP, READ_DATA_TOP, RD2_TOP;
  wire [31:0] PCPLUS, MUX1TOP, MUX2TOP, PC_target, PC_next;
  wire [2:0]  ALU_CONTROL_TOP;
  wire [1:0]  ALUOp_Top, ImmSrc_top;
  wire RegWrite, MemWrite, ALUSrc, ResultSrc, PcSrc;

  // Program Counter
  Program_Counter pc (
    .clk(clk),
    .rst(rst),
    .pc_next(PC_next),
    .pc(PC_Top)
  );

  // PC + 4 adder
  Adder add (
    .A(PC_Top),
    .B(32'd4),
    .sum(PCPLUS)
  );

  // Instruction Memory
  Instruction_Memory IM (
    .A(PC_Top),
    .rst(rst),
    .Rd(RD_Instr)
  );

  // Register File
  Register_file RF (
    .RS1(RD_Instr[19:15]),
    .RS2(RD_Instr[24:20]),
    .RS3(RD_Instr[11:7]),
    .W_Data(MUX2TOP),
    .clk(clk),
    .rst(rst),
    .W_en(RegWrite),
    .RD1(RD1_TOP),
    .RD2(RD2_TOP)
  );

  // Sign Extend
  Sign_Extend SE (
    .in(RD_Instr),
    .ImmSrc(ImmSrc_top),
    .imm_ex(imm_ex_top)
  );

  // ALU input mux
  mux1 m1 (
    .in0(RD2_TOP),
    .in1(imm_ex_top),
    .sel(ALUSrc),
    .out(MUX1TOP)
  );

  // Control Unit
  Control_unit CU (
    .op(RD_Instr[6:0]),
    .Zero(Zero_flag),
    .RegWrite(RegWrite),
    .ALUSrc(ALUSrc),
    .MemWrite(MemWrite),
    .PcSrc(PcSrc),
    .ResultSrc(ResultSrc),
    .ImmSrc(ImmSrc_top),
    .ALUOp(ALUOp_Top)
  );

  // ALU Decoder
  ALU_Decoder AD (
    .ALUOp(ALUOp_Top),
    .func7(RD_Instr[30]),
    .op5(RD_Instr[5]),
    .func3(RD_Instr[14:12]),
    .ALUControl(ALU_CONTROL_TOP)
  );

  // ALU
  ALU alu (
    .ALUControl(ALU_CONTROL_TOP),
    .A(RD1_TOP),
    .B(MUX1TOP),
    .Result(ALU_RESULT_TOP),
    .Z(Zero_flag),
    .N(Negative_flag),
    .V(Overflow_flag),
    .C(Cout_flag)
  );

  // Data Memory
  Data_Memory DM (
    .W_en(MemWrite),
    .rst(rst),
    .clk(clk),
    .Data(RD2_TOP),
    .A(ALU_RESULT_TOP[11:2]), // word addressing
    .RD(READ_DATA_TOP)
  );

  // Write-back mux
  mux2 m2 (
    .in0(ALU_RESULT_TOP),
    .in1(READ_DATA_TOP),
    .sel(ResultSrc),
    .out(MUX2TOP)
  );

  // Branch target and PC select
  assign PC_target = PC_Top + imm_ex_top;
  assign PC_next   = (PcSrc) ? PC_target : PCPLUS;

endmodule
