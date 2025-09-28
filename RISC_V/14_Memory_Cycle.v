module Memory_Cycle (
  input clk,rst,
  input Reg_WriteM,Mem_WriteM,Result_SrcM,
  input [31:0]ALU_ResultM,Write_DataM,PcPlusM,
  input [4:0]RDM,
  output Reg_WriteW,Result_SrcW,
  output [31:0] ReadDataW,PcPlusW,ALU_ResultW,
  output [4:0]RDW
  );
  
  wire [31:0] ReadDataWW_R;
  
  reg  Reg_WriteW_R,Result_SrcW_R;
  reg  [31:0] ReadDataW_R,PcPlusW_R,ALU_ResultW_R;
  reg  [4:0]RDW_R;
  
  Data_Memory DM(
                .clk(clk),
                .rst(rst),
                .data(Write_DataM),
                .addr(ALU_ResultM),
                .mem_write(Mem_WriteM),
                .out(ReadDataWW_R)
               );
               
  always @(posedge clk) begin
    if(rst) begin
      Reg_WriteW_R <= 1'b0;
      Result_SrcW_R <= 1'b0;
      ReadDataW_R <= 32'd0;
      PcPlusW_R <= 32'd0;
      RDW_R <= 5'd0;
      ALU_ResultW_R <= 32'd0;
    end
    else begin
      Reg_WriteW_R <= Reg_WriteM;
      Result_SrcW_R <= Result_SrcM;
      ReadDataW_R <= ReadDataWW_R;
      PcPlusW_R <= PcPlusM;
      RDW_R <= RDM;
      ALU_ResultW_R <= ALU_ResultM;
    end
  end
  
  assign Reg_WriteW = Reg_WriteW_R;
  assign Result_SrcW = Result_SrcW_R;
  assign ReadDataW = ReadDataW_R;
  assign PcPlusW = PcPlusW_R;
  assign RDW = RDW_R;
  assign ALU_ResultW = ALU_ResultW_R;
  
  endmodule