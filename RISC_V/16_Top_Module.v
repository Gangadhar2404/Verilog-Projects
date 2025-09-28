module TopModule (
  input clk,rst
  
  
  );
  
  wire Pc_Src;
  wire [31:0] Pc_Target,instr_D,PCD,PCPlusD;
  wire [31:0] ResultW;
  wire Reg_WriteE,Mem_WriteE,ALU_SrcE,Result_SrcE,BranchE;
  wire [2:0]ALU_ControlE;
  wire [31:0]Imm_ExE;
  wire [31:0]PCE,PcPlusE,RD1E,RD2E;
  wire [4:0]RDE;
  wire Reg_WriteM,Mem_WriteM,Result_SrcM;
  wire [31:0]ALU_ResultM,Write_DataM,PcPlusM;
  wire [4:0]RDM;
  wire Reg_WriteW,Result_SrcW;
  wire [31:0]ReadDataW,PcPlusW,ALU_ResultW;
  wire [4:0]RDW;
  
  Fetch_Cycle FC (
                   .clk(clk),
                   .rst(rst),
                   .Pc_Src(Pc_Src),
                   .Pc_Target(Pc_Target),
                   .instr_D(instr_D),
                   .PCD(PCD),
                   .PCPlusD(PCPlusD)
                  );
 Decode_Cycle DC (
                   .clk(clk),
                   .rst(rst),
                   .RegWriteW(Reg_WriteW),
                   .RDW(RDW),
                   .ResultW(ResultW),
                   .Instrc_D(instr_D),
                   .PCD(PCD),
                   .PcPlusD(PCPlusD),
                   .Reg_WriteE(Reg_WriteE),
                   .Mem_WriteE(Mem_WriteE),
                   .ALU_SrcE(ALU_SrcE),
                   .Result_SrcE(Result_SrcE),
                   .BranchE(BranchE),
                   .ALU_ControlE(ALU_ControlE),
                   .Imm_ExE(Imm_ExE),
                   .PCE(PCE),
                   .PcPlusE(PcPlusE),
                   .RDE(RDE),
                   .RD1E(RD1E),
                   .RD2E(RD2E)
                  );
 
 Execute_Cycle EC (
                    .clk(clk),
                    .rst(rst),
                    .RD1E(RD1E),
                    .RD2E(RD2E),
                    .Reg_WriteE(Reg_WriteE),
                    .Mem_WriteE(Mem_WriteE),
                    .ALU_SrcE(ALU_SrcE),
                    .Result_SrcE(Result_SrcE),
                    .BranchE(BranchE),
                    .ALU_ControlE(ALU_ControlE),
                    .Imm_ExE(Imm_ExE),
                    .PCE(PCE),
                    .PcPlusE(PcPlusE),
                    .RDE(RDE),
                    .Reg_WriteM(Reg_WriteM),
                    .Mem_WriteM(Mem_WriteM),
                    .Result_SrcM(Result_SrcM),
                    .ALU_ResultM(ALU_ResultM),
                    .Write_DataM(Write_DataM),
                    .PcPlusM(PcPlusM),
                    .Pc_Target(Pc_Target),
                    .RDM(RDM),
                    .Pc_Src(Pc_Src)
                   );                 
                  
 Memory_Cycle MC (
                   .clk(clk),
                   .rst(rst),
                   .Reg_WriteM(Reg_WriteM),
                   .Mem_WriteM(Mem_WriteM),
                   .Result_SrcM(Result_SrcM),
                   .ALU_ResultM(ALU_ResultM),
                   .Write_DataM(Write_DataM),
                   .PcPlusM(PcPlusM),
                   .RDM(RDM),
                   .Reg_WriteW(Reg_WriteW),
                   .Result_SrcW(Result_SrcW),
                   .ReadDataW(ReadDataW),
                   .PcPlusW(PcPlusW),
                   .ALU_ResultW(ALU_ResultW),
                   .RDW(RDW)
                 );
  
  Write_Back WC (          
                  .Reg_WriteW(Reg_WriteW),
                  .Result_SrcW(Result_SrcW),
                  .ReadDataW(ReadDataW),
                  .PcPlusW(PcPlusW),
                  .ALU_ResultW(ALU_ResultW),
                  .RDW(RDW),
                  .ResultW(ResultW)
                 );
endmodule
                                 
  
                   