module Decode_Cycle(
  input clk,rst,
  input RegWriteW,
  input [4:0]RDW,
  input [31:0]ResultW,
  input [31:0]Instrc_D,PCD,PcPlusD,
  output Reg_WriteE,Mem_WriteE,ALU_SrcE,Result_SrcE,BranchE,
  output [2:0]ALU_ControlE,
  output [31:0]Imm_ExE,PCE,PcPlusE,
  output [4:0]RDE,
  output [31:0] RD1E,RD2E
  );
 
 reg [31:0]RD1E_R,RD2E_R;
 reg Reg_WriteE_R,Mem_WriteE_R,ALU_SrcE_R,Result_SrcE_R,BranchE_R;
 reg [2:0]ALU_ControlE_R;
 reg [31:0]Imm_ExE_R,PCE_R,PcPlusE_R;
 reg [4:0]RDE_R;
 
 wire [31:0]RD1EW_R,RD2EW_R;
 wire Reg_WriteEW_R,Mem_WriteEW_R,ALU_SrcEW_R,Result_SrcEW_R,BranchEW_R;
 wire [1:0]Imm_SrcEW_R;
 wire [2:0]ALU_ControlEW_R;
 wire [31:0]Imm_ExEW_R;
 
Reg_Bank RB(
           .clk(clk),
           .rst(rst),
           .data(ResultW),
           .reg_write(RegWriteW),
           .RS1(Instrc_D[19:15]),
           .RS2(Instrc_D[24:20]),
           .RS3(RDW),
           .RD1(RD1EW_R),
           .RD2(RD2EW_R)
         );
         
  Sign_Extend SE(
                 .imm_src(Imm_SrcEW_R),
                 .in(Instrc_D[31:0]),
                 .data_out(Imm_ExEW_R)
                );
                
  Control_Unit CU(
               .Opcode(Instrc_D[6:0]),
               .func3(Instrc_D[14:12]),
               .func7(Instrc_D[30]),
               .Branch(BranchEW_R),
               .Mem_Write(Mem_WriteEW_R),
               .Reg_Write(Reg_WriteEW_R),
               .Result_Src(Result_SrcEW_R),
               .ALU_Src(ALU_SrcEW_R),
               .Imm_Src(Imm_SrcEW_R),
               .ALU_Control(ALU_ControlEW_R)
              ); 
                             
 
 
 always @(posedge clk) begin
   if(rst) begin
     RD1E_R <= 32'd0;
     RD2E_R <= 32'd0;
     Reg_WriteE_R <= 1'd0;
     Mem_WriteE_R <= 1'd0;
     ALU_SrcE_R <= 1'd0;
     Result_SrcE_R <=1'd0;
     BranchE_R <= 1'd0;
     ALU_ControlE_R <= 3'd0;
     Imm_ExE_R <= 32'd0;
     PCE_R <= 32'd0;
     PcPlusE_R <= 32'd0;
     RDE_R <= 5'd0; 
   end
   else begin
     RD1E_R <= RD1EW_R;
     RD2E_R <= RD2EW_R;
     Reg_WriteE_R <= Reg_WriteEW_R;
     Mem_WriteE_R <= Mem_WriteEW_R;
     ALU_SrcE_R <= ALU_SrcEW_R;
     Result_SrcE_R <= Result_SrcEW_R;
     BranchE_R <= BranchEW_R;
     ALU_ControlE_R <= ALU_ControlEW_R;
     Imm_ExE_R <= Imm_ExEW_R;
     PCE_R <= PCD;
     PcPlusE_R <= PcPlusD;
     RDE_R <= Instrc_D[11:7];  
   end
 end
 
 assign RD1E = RD1E_R;
 assign RD2E = RD2E_R;
 assign Reg_WriteE = Reg_WriteE_R;
 assign Mem_WriteE = Mem_WriteE_R;
 assign ALU_SrcE = ALU_SrcE_R;
 assign Result_SrcE = Result_SrcE_R;
 assign BranchE = BranchE_R;
 assign ALU_ControlE = ALU_ControlE_R;
 assign Imm_ExE = Imm_ExE_R;
 assign PCE = PCE_R;
 assign PcPlusE = PcPlusE_R;
 assign RDE = RDE_R;
 
 endmodule                