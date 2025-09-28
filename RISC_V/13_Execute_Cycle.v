module Execute_Cycle (
  input clk,rst,
  input [31:0] RD1E,RD2E,
  input Reg_WriteE,Mem_WriteE,ALU_SrcE,Result_SrcE,BranchE,
  input [2:0]ALU_ControlE,
  input [31:0]Imm_ExE,PCE,PcPlusE,
  input [4:0]RDE,
  output Reg_WriteM,Mem_WriteM,Result_SrcM,
  output [31:0]ALU_ResultM,Write_DataM,PcPlusM,Pc_Target,
  output [4:0]RDM,
  output Pc_Src
  );
  
  wire [31:0]mux_out;
  wire [31:0]ALU_ResultW_R;
  wire [31:0]Pc_TargetW;
  wire zeroW;
  
  
  reg Reg_WriteM_R,Mem_WriteM_R,Result_SrcM_R;
  reg [31:0]ALU_ResultM_R,Write_DataM_R,PcPlusM_R;
  reg [4:0]RDM_R; 
  
  
  ALU alu(
           .in1(RD1E),
           .in2(mux_out), 
           .ALU_Control(ALU_ControlE),
           .ALU_out(ALU_ResultW_R),
           .zero(zeroW)
          );
 Adder A2(
           .a(PCE),
           .b(Imm_ExE),
           .sum(Pc_TargetW)
          );
 MUX    M2(
            .in0(RD2E),
            .in1(Imm_ExE),
            .sel(ALU_SrcE),
            .out(mux_out)
          );
 always @(posedge clk) begin
   if(rst) begin
     Reg_WriteM_R <= 1'b0;
     Mem_WriteM_R <= 1'b0;
     Result_SrcM_R <= 1'b0;
     ALU_ResultM_R <= 32'd0;
     Write_DataM_R <= 32'd0;
     PcPlusM_R <= 32'd0;
     RDM_R <= 5'd0;
   end
   else begin
     Reg_WriteM_R <= Reg_WriteE;
     Mem_WriteM_R <= Mem_WriteE;
     Result_SrcM_R <= Result_SrcE;
     ALU_ResultM_R <= ALU_ResultW_R;
     Write_DataM_R <= RD2E;
     PcPlusM_R <= PcPlusE;
     RDM_R <= RDE;         
   end
 end
 
 assign Reg_WriteM = Reg_WriteM_R;
 assign Mem_WriteM = Mem_WriteM_R;
 assign Result_SrcM = Result_SrcM_R;
 assign ALU_ResultM = ALU_ResultM_R;
 assign Write_DataM = Write_DataM_R;
 assign PcPlusM = PcPlusM_R;
 assign Pc_Target = Pc_TargetW;
 assign RDM = RDM_R;
 assign Pc_Src = zeroW & BranchE;
endmodule                